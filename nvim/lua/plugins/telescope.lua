return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		cmd = { "Telescope" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"protex/better-digraphs.nvim",
		},
		keys = {
			{
				"<c-k><c-k>",
				function()
					require("better-digraphs").digraphs("insert")
				end,
				mode = "i",
				desc = "Insert digraph",
			},
		},
		config = function()
			-- Exclude built-in themes from telescppe colorscheme chooser
			local builtin_themes = vim.split(vim.fn.glob("$VIMRUNTIME" .. "/colors/*"), "\n")
			vim.opt.wildignore:append(builtin_themes)

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
				extensions = {
					aerial = {},
				},
			})

			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")

			do
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

				local function categorize_schemes(colorscheme_files)
					local themes = {}

					for _, name in ipairs(colorscheme_files) do
						vim.cmd("colorscheme " .. name)
						local group = vim.o.background == "light" and "Light"
							or vim.o.background == "dark" and "Dark"
							or "Other"
						local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
						local hl_group = "Normal"
						if hl and (hl.fg or hl.bg) then
							hl_group = "ColorSchemePreview_" .. name:gsub("[^%w_]", "_")
							vim.api.nvim_set_hl(0, hl_group, { fg = hl.fg, bg = hl.bg })
						end
						local hex = string.format("#%06x", hl.bg or 0xffffff)
						local hue, saturation, brightness = hsv_from_hex(hex)
						table.insert(themes, {
							name = name,
							group = group,
							fg = hl.fg,
							bg = hl.bg,
							hue = hue,
							saturation = saturation,
							brightness = brightness,
							hl_group = hl_group,
						})
					end

					assign_buckets("brightness", "brightness_bucket", 0.012, themes)

					table.sort(themes, function(a, b)
						if a.group ~= b.group then
							return a.group < b.group -- light before dark
						end

						if a.brightness_bucket ~= b.brightness_bucket then
							return a.brightness_bucket < b.brightness_bucket
						end

						local a_neutral = (a.saturation <= 0.2)
						local b_neutral = (b.saturation <= 0.2)
						if a_neutral ~= b_neutral then
							return a_neutral
						end

						if a_neutral and b_neutral then
							return a.brightness < b.brightness
						end

						if math.abs(a.hue - b.hue) > 1 then
							return a.hue < b.hue
						end

						return a.brightness < b.brightness
					end)

					return themes
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
							name = theme.name,
							hl_group = theme.hl_group,
							group = theme.group,
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
								{ string.format("%-7s", "[" .. item.group .. "]"), "Secondary" },
								{ format_name(item.name), item.hl_group },
							}
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
