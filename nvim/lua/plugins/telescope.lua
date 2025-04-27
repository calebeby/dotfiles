return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
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
				pickers = {
					colorscheme = {
						enable_preview = true,
						colors = {
							before_color = "default",
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
							entries[#entries + 1] = { value = val, item = v }
						end
					end
					table.sort(entries, function(a, b)
						return a.value < b.value
					end)

					local bucket = 1
					local last_val = nil
					for _, e in ipairs(entries) do
						if last_val ~= nil and e.value - last_val >= threshold then
							bucket = bucket + 1
						end
						e.item[dest_prop] = bucket
						last_val = e.value
					end
				end

				-- Better than built-in because it separates light vs dark themes
				local function colorscheme_picker()
					local pickers = require("telescope.pickers")
					local finders = require("telescope.finders")
					local previewers = require("telescope.previewers")
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")
					local conf = require("telescope.config").values

					local current_colorscheme = vim.g.colors_name

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

					local function format_name(name)
						return name:gsub("([a-z])([a-z]*)", function(first, rest)
							return first:upper() .. rest:lower()
						end):gsub("_", " ")
					end

					local function launch_picker()
						local colorscheme_files = vim.fn.getcompletion("", "color")
						local themes
						if cached_themes then
							themes = cached_themes
						else
							themes = categorize_schemes(colorscheme_files)
							cached_themes = themes
						end

						local bufnr = vim.api.nvim_get_current_buf()
						local p = vim.api.nvim_buf_get_name(bufnr)

						-- Find the index of the current colorscheme
						local default_index = nil
						for i, entry in ipairs(themes) do
							if entry.name == current_colorscheme then
								default_index = i
								break
							end
						end

						pickers
							.new({}, {
								prompt_title = "Colorschemes (light/dark)",
								finder = finders.new_table({
									results = themes,
									entry_maker = function(entry)
										local display = string.format("[%s] %s", entry.group, format_name(entry.name))
										return {
											value = entry,
											display = function()
												return display,
													{ { { entry.group:len() + 3, display:len() }, entry.hl_group } }
											end,
											ordinal = display,
										}
									end,
								}),
								sorter = conf.generic_sorter({}),
								default_selection_index = default_index,
								previewer = previewers.new_buffer_previewer({
									get_buffer_by_name = function()
										return p
									end,
									define_preview = function(self, entry)
										vim.cmd("colorscheme " .. entry.value.name)
										-- Ensure the buffer exists on disk before proceeding
										if vim.loop.fs_stat(p) then
											-- If the file exists, use the buffer previewer maker
											conf.buffer_previewer_maker(
												p,
												self.state.bufnr,
												{ bufname = self.state.bufname }
											)

											-- Set filetype to match the current buffer
											local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
											vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", filetype)
										else
											-- If the file does not exist, directly set the content from the current buffer
											local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
											vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
										end
									end,
								}),
								attach_mappings = function(_, map)
									-- When selecting a colorscheme, change it
									actions.select_default:replace(function()
										local selection = action_state.get_selected_entry()
										actions.close(_)
										vim.cmd("colorscheme " .. selection.value.name)
									end)

									-- When pressing ESC, reset to the original colorscheme
									map("i", "<Esc>", function()
										actions.close(_)
										vim.cmd("colorscheme " .. current_colorscheme)
									end)

									return true
								end,
							})
							:find()
					end

					launch_picker()
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
