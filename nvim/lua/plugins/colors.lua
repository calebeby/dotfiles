return {
	{
		dir = "~/dotfiles/vim-colors",
		name = "colors",
		config = function()
			vim.cmd([[colorscheme one_dark]])

			-- Colorscheme picker (<leader>kt)
			do
				-- Exclude built-in themes from colorscheme chooser
				local builtin_themes = vim.split(vim.fn.glob("$VIMRUNTIME" .. "/colors/*"), "\n")
				vim.opt.wildignore:append(builtin_themes)

				local cached_themes = false
				local cache_path = vim.fn.stdpath("data") .. "/theme_cache.json"

				local function hsv_from_hex(hex)
					hex = hex:gsub("#", "")
					local r = tonumber(hex:sub(1, 2), 16) / 255
					local g = tonumber(hex:sub(3, 4), 16) / 255
					local b = tonumber(hex:sub(5, 6), 16) / 255
					local maxc, minc = math.max(r, g, b), math.min(r, g, b)
					local v = maxc
					local d = maxc - minc
					local s = (maxc == 0) and 0 or d / maxc
					local h
					if d == 0 then
						h = 0
					else
						if maxc == r then
							h = ((g - b) / d + (g < b and 6 or 0)) * 60
						elseif maxc == g then
							h = ((b - r) / d + 2) * 60
						else
							h = ((r - g) / d + 4) * 60
						end
					end
					return h, s, v
				end

				local function get_feature_vector(name)
					local ok = pcall(vim.cmd, "colorscheme " .. name)
					if not ok then
						return nil
					end

					local function get_hsv_full(group, attr)
						local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
						local hex = string.format("#%06x", hl[attr] or (attr == "bg" and 0x000000 or 0xffffff))
						local h, s, v = hsv_from_hex(hex)
						-- Convert Hue to Radians for circular math
						local rad = (h / 360) * 2 * math.pi
						return math.cos(rad), math.sin(rad), s, v
					end

					local is_dark
					if vim.o.background == "light" then
						is_dark = 100
					else
						is_dark = 0
					end

					-- Extract data with circular hue (cos, sin)
					local b_hx, b_hy, bs, bv = get_hsv_full("Normal", "bg")
					local f_hx, f_hy, fs, fv = get_hsv_full("Normal", "fg")
					local c_cx, c_sy, cs, cv = get_hsv_full("Comment", "fg")
					local k_cx, k_sy, ks, kv = get_hsv_full("Keyword", "fg")

					-- FEATURE VECTOR:
					local vec = {
						is_dark,
						b_hx * 10,
						b_hy * 10,
						bs * 10,
						bv * 10,
						f_hx,
						f_hy,
						fv,
						cs,
						cv,
						ks,
						kv,
					}

					local hl_group = "ColorSchemePreview_" .. name:gsub("[^%w_]", "_")
					local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
					local bg = normal.bg
					local fg = normal.fg
					vim.api.nvim_set_hl(0, hl_group, { fg = fg, bg = bg })

					return {
						name = name,
						group = vim.o.background,
						vec = vec,
						hl_group = hl_group,
						bg = bg,
						fg = fg,
					}
				end

				local function sort_by_pca(themes)
					if #themes < 2 then
						return themes
					end
					local n = #themes
					local dims = #themes[1].vec

					-- 1. Center the data
					local means = {}
					for i = 1, dims do
						local sum = 0
						for j = 1, n do
							sum = sum + themes[j].vec[i]
						end
						means[i] = sum / n
					end

					local centered = {}
					for j = 1, n do
						centered[j] = {}
						for i = 1, dims do
							centered[j][i] = themes[j].vec[i] - means[i]
						end
					end

					-- 2. Power Iteration to find Eigenvector
					local b = {}
					for i = 1, dims do
						b[i] = math.random()
					end

					for _ = 1, 1000 do
						local next_b = {}
						for i = 1, dims do
							next_b[i] = 0
						end
						for i = 1, dims do
							for j = 1, n do
								local dot = 0
								for k = 1, dims do
									dot = dot + centered[j][k] * b[k]
								end
								next_b[i] = next_b[i] + centered[j][i] * dot
							end
						end
						local norm = 0
						for i = 1, dims do
							norm = norm + next_b[i] ^ 2
						end
						norm = math.sqrt(norm)
						if norm == 0 then
							break
						end
						for i = 1, dims do
							b[i] = next_b[i] / norm
						end
					end

					-- 3. Project and Sort
					for i, theme in ipairs(themes) do
						local score = 0
						for d = 1, dims do
							score = score + centered[i][d] * b[d]
						end
						theme.groupid = string.format("%.2f", score)
						theme.pca_score = score
					end

					table.sort(themes, function(a, b)
						return a.pca_score < b.pca_score
					end)
					return themes
				end

				local function categorize_schemes(colorscheme_files)
					local themes = {}
					local current_colorscheme = vim.g.colors_name

					for _, name in ipairs(colorscheme_files) do
						local theme_data = get_feature_vector(name)
						if theme_data and theme_data.vec then
							table.insert(themes, theme_data)
						end
					end

					-- Restore original theme
					pcall(vim.cmd, "colorscheme " .. current_colorscheme)
					return sort_by_pca(themes)
				end

				local function update_theme_cache()
					local current_colorscheme = vim.g.colors_name
					local colorscheme_files = vim.fn.getcompletion("", "color")
					cached_themes = categorize_schemes(colorscheme_files)
					local file = io.open(cache_path, "w")
					if file then
						file:write(vim.json.encode(cached_themes))
						file:close()
					end
					vim.cmd("colorscheme " .. current_colorscheme)
				end
				vim.api.nvim_create_user_command("UpdateColorSchemes", update_theme_cache, {
					desc = "Re-categorize colorschemes and save to JSON cache",
				})

				local function format_name(name)
					return name:gsub("([a-z])([a-z]*)", function(first, rest)
						return first:upper() .. rest:lower()
					end):gsub("_", " ")
				end

				-- Better than built-in because it separates light vs dark themes
				local function colorscheme_picker()
					local current_colorscheme = vim.g.colors_name

					-- Load Cache
					if not cached_themes then
						local file = io.open(cache_path, "r")
						if file then
							cached_themes = vim.json.decode(file:read("*all"))
							file:close()

							for _, hl in ipairs(cached_themes) do
								if hl.fg or hl.bg then
									vim.api.nvim_set_hl(0, hl.hl_group, { fg = hl.fg, bg = hl.bg })
								end
							end
						else
							-- no cache, even in JSON file, run the slow function
							update_theme_cache()
						end
					end

					local items = {}
					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					for _, theme in ipairs(cached_themes) do
						table.insert(items, {
							text = format_name(theme.name),
							name = theme.name,
							hl_group = theme.hl_group,
							group = theme.group,
							groupid = theme.groupid,
							file = vim.api.nvim_buf_get_name(0),
							pos = cursor_pos,
						})
					end

					Snacks.picker.pick({
						source = "custom_colorschemes",
						finder = function()
							return items
						end,
						sort = false,
						title = "Colorschemes",
						format = function(item, _)
							return {
								{ string.format("%-12s", "[" .. item.groupid .. "] "), "Secondary" },
								{ item.text, item.hl_group },
							}
						end,
						on_show = function(picker)
							for i, item in ipairs(picker:items()) do
								if item.name == current_colorscheme then
									picker.list:view(i)
									break
								end
							end
						end,
						on_change = function(_, item)
							if item then
								pcall(vim.cmd, "colorscheme " .. item.name)
							end
						end,
						confirm = function(picker, item)
							picker:close()
							if item then
								pcall(vim.cmd, "colorscheme " .. item.name)
							end
						end,
						on_close = function()
							if vim.g.colors_name ~= current_colorscheme then
								vim.cmd("colorscheme " .. current_colorscheme)
							end
						end,
						layout = {
							preset = "left",
							layout = { width = 40, min_width = 0 },
							hidden = { "preview" },
						},
					})
				end

				vim.keymap.set("n", "<leader>kt", colorscheme_picker, {
					desc = "Select colorscheme",
					noremap = true,
					silent = true,
				})
			end
		end,
	},
}
