return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		cmd = { "Telescope" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"zk-org/zk-nvim",
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
					undo = {
						use_delta = false,
						vim_diff_opts = {
							ctxlen = 5,
						},
						mappings = {
							i = {
								["<cr>"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			})

			require("telescope").load_extension("undo")
			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("zk")

			do
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

						for _, cs in ipairs(colorscheme_files) do
							vim.cmd("colorscheme " .. cs)
							local group = vim.o.background == "light" and "Light"
								or vim.o.background == "dark" and "Dark"
								or "Other"
							table.insert(themes, { name = cs, group = group })
						end

						table.sort(themes, function(a, b)
							return a.group == b.group and a.name < b.name or a.group < b.group
						end)

						return themes
					end

					local function format_name(name)
						return name:gsub("([a-z])([a-z]*)", function(first, rest)
							return first:upper() .. rest:lower()
						end):gsub("_", " ")
					end

					local cached_themes = false

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

						pickers
							.new({}, {
								prompt_title = "Colorschemes (light/dark)",
								finder = finders.new_table({
									results = themes,
									entry_maker = function(entry)
										return {
											value = entry,
											display = string.format("[%s] %s", entry.group, format_name(entry.name)),
											ordinal = entry.name,
										}
									end,
								}),
								sorter = conf.generic_sorter({}),
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
