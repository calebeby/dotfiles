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

				local function assign_buckets(source_prop, dest_prop, threshold, items)
					local entries = {}
					for _, v in ipairs(items) do
						local val = v[source_prop]
						if type(val) == "number" then
							table.insert(entries, { value = val, item = v })
						end
					end
					table.sort(entries, function(a, b)
						return a.value < b.value
					end)
					local bucket, last_val = 1, nil
					for _, e in ipairs(entries) do
						if last_val ~= nil and e.value - last_val >= threshold then
							bucket = bucket + 1
						end
						e.item[dest_prop] = bucket
						last_val = e.value
					end
				end

				local function get_feature_vector(name)
					local ok = pcall(vim.cmd, "colorscheme " .. name)
					if not ok then
						return nil
					end

					local function get_hsv(group, attr)
						local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
						local hex = string.format("#%06x", hl[attr] or (attr == "bg" and 0x000000 or 0xffffff))
						return hsv_from_hex(hex)
					end

					local function get_hsv_full(group, attr)
						local h, s, v = get_hsv(group, attr)
						return h / 360, s, v
					end

					local bh, bs, bv = get_hsv_full("Normal", "bg")
					local fh, fs, fv = get_hsv_full("Normal", "fg")
					local ch, cs, cv = get_hsv_full("Comment", "fg")
					local kh, ks, kv = get_hsv_full("Keyword", "fg")
					local funh, _, _ = get_hsv_full("Function", "fg")
					local sh, _, _ = get_hsv_full("String", "fg")
					local conh, _, _ = get_hsv_full("Constant", "fg")

					local vec = {
						bh * 2,
						bs * 2,
						bv * 10, -- Background
						fh,
						fs,
						fv, -- Foreground
						ch,
						cs,
						cv, -- Comments (High vs Low contrast vibe)
						kh,
						ks,
						kv, -- Keywords (Main accent)
						funh,
						sh,
						conh, -- Secondary Hue signatures
					}

					local hl_group = "ColorSchemePreview_" .. name:gsub("[^%w_]", "_")
					local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
					local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
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

				local function calculate_distance(v1, v2)
					local sum = 0
					for i = 1, #v1 do
						local diff = v1[i] - v2[i]
						-- Weights: Give background Value and Hue more importance for "vibe"
						-- local weight = (i == 3) and 10 or 1
						local weight = 1
						sum = sum + (diff * diff * weight)
					end
					return math.sqrt(sum)
				end

				local function cluster_and_sort_vectors(themes, num_groups, recurse_limit)
					if #themes == 0 then
						return {}
					end
					num_groups = math.min(num_groups, #themes)

					-- Initialize centroids (pick random themes as starting points)
					local centroids = {}
					for i = 1, num_groups do
						centroids[i] = { vec = themes[math.random(#themes)].vec }
					end

					for _ = 1, 100 do
						for i = 1, num_groups do
							centroids[i].items = {}
						end

						-- Assign themes to closest centroid
						for _, theme in ipairs(themes) do
							local best_dist = math.huge
							local best_idx = 1
							for i = 1, num_groups do
								local d = calculate_distance(theme.vec, centroids[i].vec)
								if d < best_dist then
									best_dist = d
									best_idx = i
								end
							end
							table.insert(centroids[best_idx].items, theme)
						end

						-- Update centroids (calculate average vector of the bucket)
						for i = 1, num_groups do
							if #centroids[i].items > 0 then
								local avg = {}
								for j = 1, #themes[1].vec do
									avg[j] = 0
								end
								for _, item in ipairs(centroids[i].items) do
									for j = 1, #item.vec do
										avg[j] = avg[j] + item.vec[j]
									end
								end
								for j = 1, #avg do
									centroids[i].vec[j] = avg[j] / #centroids[i].items
								end
							end
						end
					end

					-- 2. Sort the centroids themselves (Darkest to Lightest, then Hue)
					table.sort(centroids, function(a, b)
						if a.vec[3] ~= b.vec[3] then
							return a.vec[3] < b.vec[3]
						end
						return a.vec[1] < b.vec[1]
					end)

					-- 3. Flatten and perform intra-bucket sort
					local final_list = {}
					for i, center in ipairs(centroids) do
						for _, item in ipairs(center.items) do
							if not item.groupid then
								item.groupid = "" .. i
							else
								item.groupid = item.groupid .. "-" .. i
							end
						end
						if recurse_limit > 1 and #center.items >= 2 then
							center.items = cluster_and_sort_vectors(center.items, num_groups, recurse_limit - 1)
						else
							-- Sort themes inside this bucket by background brightness
							table.sort(center.items, function(a, b)
								if math.abs(a.vec[3] - b.vec[3]) > 0.01 then
									return a.vec[3] < b.vec[3]
								end
								return a.vec[1] < b.vec[1]
							end)
						end

						for _, item in ipairs(center.items) do
							table.insert(final_list, item)
						end
					end

					return final_list
				end

				local function cluster_themes(themes)
					if #themes == 0 then
						return {}
					end

					return cluster_and_sort_vectors(themes, 2, 4)
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

					-- Now perform the vector space clustering
					return cluster_themes(themes)
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
								{
									string.format("%-7s", "[" .. item.group .. "] [" .. item.groupid .. "] "),
									"Secondary",
								},
								{ item.text, item.hl_group },
							}
						end,
						on_show = function(picker)
							local target_value = current_colorscheme

							-- Select current colorscheme when picker opens
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
