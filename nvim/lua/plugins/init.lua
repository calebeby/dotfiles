-- Allows updating highlights initially and when color scheme is changed/replaced
local highlight_hook = function(update_color)
	vim.api.nvim_create_autocmd("ColorScheme", { callback = update_color })
	update_color()
end

return {
	"nvim-tree/nvim-web-devicons",
	{
		"echasnovski/mini.files",
		config = function()
			local function split_alpha_num(str)
				local parts = {}
				-- normalize case
				str = str:lower()
				-- wrap every digit sequence in NULs so we can split on them
				local tmp = str:gsub("(%d+)", "\0%1\0")
				-- split on NUL (Lua pattern %z)
				for part in tmp:gmatch("([^%z]+)") do
					local n = tonumber(part)
					table.insert(parts, n or part)
				end
				return parts
			end

			local function natural_compare(a, b)
				-- directories first
				if a.is_dir ~= b.is_dir then
					return a.is_dir
				end

				local A = split_alpha_num(a.name)
				local B = split_alpha_num(b.name)

				for i = 1, math.max(#A, #B) do
					local x, y = A[i], B[i]
					if x == nil then
						return true
					end
					if y == nil then
						return false
					end
					if x ~= y then
						if type(x) == type(y) then
							return x < y
						else
							return type(x) == "number"
						end
					end
				end

				return false
			end

			local sorter = function(fs_entries)
				local res = vim.tbl_map(function(x)
					return {
						fs_type = x.fs_type,
						name = x.name,
						path = x.path,
						is_dir = x.fs_type == "directory",
					}
				end, fs_entries)

				table.sort(res, natural_compare)

				return vim.tbl_map(function(x)
					return { name = x.name, fs_type = x.fs_type, path = x.path }
				end, res)
			end

			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "<CR>", -- automatically close after selecting a file
					go_out = "h",
					go_out_plus = "",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
				content = {
					sort = sorter,
				},
				options = {
					permanent_delete = false,
				},
			})

			local show_dotfiles = true

			local filter_show = function(fs_entry)
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				MiniFiles.refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Tweak left-hand side of mapping to your liking
					vim.keymap.set("n", "g.", toggle_dotfiles, {
						buffer = buf_id,
						desc = "Toggle dotfiles",
					})
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					-- This snacks plugin notifies LSP that file has been renamed
					require("snacks").rename.on_rename_file(event.data.from, event.data.to)
				end,
			})
		end,
	},
	{
		"echasnovski/mini.statusline",
		config = function()
			vim.api.nvim_create_autocmd("RecordingEnter", {
				pattern = "*",
				callback = function()
					vim.cmd("redrawstatus")
				end,
			})
			vim.api.nvim_create_autocmd("RecordingLeave", {
				pattern = "*",
				callback = function()
					vim.cmd("redrawstatus")
				end,
			})

			require("mini.statusline").setup({
				content = {
					active = function()
						local check_macro_recording = function()
							if vim.fn.reg_recording() ~= "" then
								return "Recording @" .. vim.fn.reg_recording()
							else
								return ""
							end
						end

						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local git = MiniStatusline.section_git({ trunc_width = 40 })
						local diff = MiniStatusline.section_diff({ trunc_width = 75 })
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
						local filename = MiniStatusline.section_filename({ trunc_width = 140 })
						local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
						local location = MiniStatusline.section_location({ trunc_width = 75 })
						local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
						local macro = check_macro_recording()

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "ModeMsg", strings = { macro } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { search, location } },
						})
					end,
				},
			})
		end,
	},
	{
		-- Motion plugin like leap/sneak/easymotion/lightspeed/hop
		"folke/flash.nvim",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"<space>",
				mode = { "v", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Surrounding TS node (Flash)",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").jump({
						remote_op = {
							restore = true,
							motion = true,
						},
					})
				end,
				desc = "Remote (Flash)",
			},
		},
		config = function()
			require("flash").setup()
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#000000", bold = true })
			end)
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			local wk = require("which-key")
			wk.setup({ delay = 100 })
			wk.add({
				{ "<leader>c", group = "context" },
				{ "<leader>o", group = "open" },
				{ "<leader>d", group = "harpoon" },
				{ "<leader>S", group = "snippets" },
				{ "<leader>r", group = "refactor" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "hunk" },
				{ "<leader>k", group = "preferences" },
				{ "<leader>t", group = "toggle" },
				{ "<leader>x", group = "diagnostics" },
				{ "<leader>w", group = "window", proxy = "<c-w>" },
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "",
					replace = "cs",
					update_n_lines = "",

					-- Add this only if you don't want to use extended mappings
					suffix_last = "",
					suffix_next = "",
				},
				n_lines = 1000,
				search_method = "cover_or_next",
			})
		end,
	},
	{
		"echasnovski/mini.bracketed",
		event = "VeryLazy",
		opts = {},
	},
	{
		-- Sets vim.ui.input to a reasonable box
		-- Sets vim.ui.select to telescope selector
		-- (example use: LSP rename or LSP code action)
		-- This is better than telescope-ui-select.nvim because it allows lazy-loading telescope
		-- and it works with vim.ui.input
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		-- Highlight word/keyword under cursor
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 10,
				filetypes_denylist = {
					"NeogitStatus",
					"minifiles",
					"grug-far",
					"DiffviewFiles",
					"djot",
					"snacks_terminal",
					"markdown",
					"gitcommit",
				},
			})
			-- Avoid using default underline since some colorschemes don't define these plugin-specific hl
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
				vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })
			end)
		end,
	},
	{
		-- Briefly highlight where cursor is after big jumps
		"danilamihailov/beacon.nvim",
		event = "VeryLazy",
		config = function()
			vim.g.beacon_timeout = 200
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "Beacon", { link = "Search" })
			end)
		end,
	},
	{
		-- Paste over text (replace)
		-- Modern alternative to vim-scripts/ReplaceWithRegister
		"gbprod/substitute.nvim",
		keys = {
			{
				"R",
				mode = { "n" },
				function()
					require("substitute").operator()
				end,
				desc = "Replace operator",
			},
			{
				"RR",
				mode = { "n" },
				function()
					require("substitute").line()
				end,
				desc = "Replace current line",
			},
			{
				"R",
				mode = { "x" },
				function()
					require("substitute").visual()
				end,
				desc = "Replace selection",
			},
		},
		config = function()
			local sub = require("substitute")
			sub.setup({ highlight_substituted_text = { enabled = false } })
		end,
	},
	{
		"calebeby/yankwin.nvim",
		dir = "~/Programming/calebeby/yankwin",
		config = function()
			local yankwin = require("yankwin")
			yankwin.setup()

			vim.keymap.set("n", "<C-w>d", function()
				yankwin.Delete({ path_type = "relative", with_line_number = false })
			end, { noremap = true, silent = true, desc = "Delete buffer, yank relative file path" })

			vim.keymap.set("n", "<C-w>gd", function()
				yankwin.Delete({ path_type = "absolute", with_line_number = false })
			end, { noremap = true, silent = true, desc = "Delete buffer, yank absolute file path" })

			vim.keymap.set("n", "<C-w>D", function()
				yankwin.Delete({ path_type = "relative", with_line_number = true })
			end, { noremap = true, silent = true, desc = "Delete buffer, yank relative file path w/ line" })

			vim.keymap.set("n", "<C-w>gD", function()
				yankwin.Delete({ path_type = "absolute", with_line_number = true })
			end, { noremap = true, silent = true, desc = "Delete buffer, yank absolute file path w/ line" })

			vim.keymap.set("t", "<C-w>d", function()
				yankwin.Delete({ path_type = "terminal" })
			end, { noremap = true, silent = true, desc = "Delete buffer, yank term #" })

			vim.keymap.set("n", "<C-w>y", function()
				yankwin.Yank({ path_type = "relative", with_line_number = false })
			end, { noremap = true, silent = true, desc = "Yank relative file path" })

			vim.keymap.set("n", "<C-w>gy", function()
				yankwin.Yank({ path_type = "absolute", with_line_number = false })
			end, { noremap = true, silent = true, desc = "Yank absolute file path" })

			vim.keymap.set("n", "<C-w>Y", function()
				yankwin.Yank({ path_type = "relative", with_line_number = true })
			end, { noremap = true, silent = true, desc = "Yank relative file path w/ line" })

			vim.keymap.set("n", "<C-w>gY", function()
				yankwin.Yank({ path_type = "absolute", with_line_number = true })
			end, { noremap = true, silent = true, desc = "Yank absolute file path w/ line" })

			vim.keymap.set("t", "<C-w>y", function()
				yankwin.Yank({ path_type = "terminal" })
			end, { noremap = true, silent = true, desc = "Yank term #" })

			vim.keymap.set("n", "<C-w>R", function()
				yankwin.Paste({ edit_command = "edit" })
			end, { noremap = true, silent = true, desc = "Replace window with yanked path" })

			vim.keymap.set("n", "<C-w>p", function()
				yankwin.Paste({ edit_command = "rightbelow split" })
			end, { noremap = true, silent = true, desc = "Paste window path (rightbelow)" })

			vim.keymap.set("n", "<C-w>P", function()
				yankwin.Paste({ edit_command = "leftabove split" })
			end, { noremap = true, silent = true, desc = "Paste window path (leftabove)" })

			vim.keymap.set("n", "<C-w>gp", function()
				yankwin.Paste({ edit_command = "tab split" })
			end, { noremap = true, silent = true, desc = "Paste window path (new tab)" })

			vim.keymap.set("n", "<C-w>gP", function()
				local prior_tab = tostring(vim.fn.tabpagenr() - 1)
				yankwin.Paste({ edit_command = prior_tab .. "tab split" })
			end, { noremap = true, silent = true, desc = "Paste window path (prior tab)" })

			vim.keymap.set("t", "<C-w>R", function()
				yankwin.Paste({ edit_command = "edit" })
			end, { noremap = true, silent = true, desc = "Replace window with yanked term #" })

			vim.keymap.set("t", "<C-w>p", function()
				yankwin.Paste({ edit_command = "rightbelow split" })
			end, { noremap = true, silent = true, desc = "Paste window path (rightbelow)" })
			vim.keymap.set("t", "<C-w>P", function()
				yankwin.Paste({ edit_command = "leftabove split" })
			end, { noremap = true, silent = true, desc = "Paste window path (leftabove)" })
			vim.keymap.set("t", "<C-w>gp", function()
				yankwin.Paste({ edit_command = "tab split" })
			end, { noremap = true, silent = true, desc = "Paste window path (new tab)" })
			vim.keymap.set("t", "<C-w>gP", function()
				local prior_tab = tostring(vim.fn.tabpagenr() - 1)
				yankwin.Paste({ edit_command = prior_tab .. "tab split" })
			end, { noremap = true, silent = true, desc = "Paste window path (prior tab)" })
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>F",
				function()
					require("grug-far").open({ windowCreationCommand = "tab split" })
				end,
				desc = "Find/Replace in Project",
			},
			{
				"<c-f>",
				function()
					require("grug-far").open({
						prefills = { search = vim.fn.expand("<cword>") },
						windowCreationCommand = "tab split",
					})
				end,
				desc = "Find/Replace in Project (word under cursor)",
			},
			{
				"<c-f>",
				mode = { "v" },
				function()
					require("grug-far").open({ windowCreationCommand = "tab split" })
				end,
				desc = "Find/Replace in Project (selection)",
			},
		},
		opts = {
			debounceMs = 50,
			startInInsertMode = false,
			keymaps = {
				close = { n = "q", desc = "Quit" },
			},
		},
	},
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "0.3.*",
		opts = {
			open_cmd = "google-chrome --app=%s >/dev/null 2>&1",
		},
		build = function()
			require("typst-preview").update()
		end,
	},
	{
		"goropikari/front-matter.nvim",
		opts = {},
		build = "make setup",
	},
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<leader>os",
				function()
					require("snacks").picker.smart({ ignored = true })
				end,
				desc = "Smart file picker (buffers, recents, files)",
			},
			{
				"<leader>oo",
				function()
					require("snacks").picker()
				end,
				desc = "Select snacks picker",
			},
			{
				"<leader>of",
				function()
					require("snacks").picker.git_files({ untracked = true })
				end,
				desc = "Select file to open (files in git repo)",
			},
			{
				"<leader>or",
				function()
					require("snacks").picker.resume()
				end,
				desc = "Restore last picker",
			},
			{
				"<leader>oF",
				function()
					require("snacks").picker.files({ ignored = true })
				end,
				desc = "Select file to open (incl. untracked/ignored)",
			},
			{
				"<leader>ogl",
				function()
					require("snacks").picker.git_log()
				end,
				desc = "Open git log",
			},
			{
				"<leader>ogs",
				function()
					require("snacks").picker.git_status({
						focus = "list",
						win = {
							input = {
								keys = {
									["<Space>"] = "git_stage",
									["<Tab>"] = "focus_preview",
								},
							},
							preview = {
								keys = {
									["<Space>"] = "git_stage",
									["<Tab>"] = "focus_list",
									["h"] = "focus_list",
								},
							},
							list = {
								keys = {
									["<Space>"] = "git_stage",
									["<Tab>"] = "focus_preview",
									["l"] = "focus_preview",
								},
							},
						},
					})
				end,
				desc = "Open git status",
			},
			{
				"<leader>ogd",
				function()
					require("snacks").picker.git_diff()
				end,
				desc = "Open git diff",
			},
			{
				"<leader>oj",
				function()
					require("snacks").picker.jumps()
				end,
				desc = "Open git diff",
			},
			{
				"<leader>f",
				function()
					require("snacks").picker("grep")
				end,
			},
			{
				"<leader>0",
				function()
					local fm = require("front-matter")
					local cwd = vim.fn.getcwd()
					local files = vim.fn.globpath(cwd, "**/*/_*/**/*.dj", true, true)

					if #files == 0 then
						files = vim.fn.globpath(cwd, "**/*.dj", true, true)
					end

					-- Batch get frontmatter for these files
					local metadata = fm.get(files)

					require("snacks").picker({
						finder = "files",
						layout = {
							fullscreen = true,
							layout = {
								backdrop = false,
								border = "none",
								box = "horizontal",
								{
									box = "vertical",
									border = "none",
									title = "{title} {live} {flags}",
									title_pos = "center",
									{ win = "input", height = 1, border = "bottom" },
									{ win = "list", border = "none" },
								},
								{ win = "preview", title = "{preview}", width = 0.5, border = "rounded" },
							},
						},
						auto_close = true,
						transform = function(item)
							local match = item.file:match("^(.*)%.dj$")
							if not match then
								return false
							end
							local data = metadata[vim.fn.fnamemodify(item.file, ":p")]
							if not data or next(data) == nil then
								return false
							end
							for key, value in pairs(data) do
								if type(value) == "table" then
									item[key] = table.concat(value, ", ")
								else
									item[key] = tostring(value)
								end
							end
							if item.tags then
								item.text = item.tags .. item.file
							else
								item.text = item.file
							end
							return item
						end,
						format = function(match)
							local r = { { match.file, "DiffAdd" } }
							if match.tags then
								table.insert(r, { " tags: ", "Normal" })
								local i = 0
								for tag in match.tags:gmatch("([^,]+)") do
									if i > 0 then
										table.insert(r, { ", " })
									end
									-- trim leading/trailing whitespace
									tag = tag:match("^%s*(.-)%s*$")
									table.insert(r, { tag, "CESearchTag" })
									i = i + 1
								end
							end
							return r
						end,
						show_empty = true,
						hidden = false,
						ignored = false,
						follow = false,
						supports_live = true,
					})
				end,
			},
			{
				"<leader>E",
				function()
					require("snacks").explorer()
				end,
				desc = "Open file explorer (snacks.explorer)",
			},
			{
				"<a-t>",
				mode = { "n", "t" },
				function()
					require("snacks").terminal.toggle()
				end,
				desc = "Toggle Terminal",
			},
		},
		init = function()
			require("snacks").setup({
				indent = {
					enabled = true,
					indent = {
						enabled = true,
						only_current = true, -- Only current window
						hl = "SnacksIndent",
						char = "▏",
					},
					scope = {
						hl = "SnacksIndent",
						only_current = true, -- Only current window
						char = "▎",
					},
					chunk = {
						enabled = false,
						char = ">",
					},
					animate = { enabled = true },
				},
				terminal = {},
				image = {
					formats = {
						"png",
						"jpg",
						"jpeg",
						"gif",
						"bmp",
						"webp",
						"tiff",
						"heic",
						"avif",
						"mp4",
						"mov",
						"avi",
						"mkv",
						"webm",
						"pdf",
						"svg",
					},
					doc = {
						inline = false,
						float = true,
						max_width = 35,
						max_height = 10,
					},
					math = { latex = { font_size = "LARGE" } },
				},
				notifier = {},
				lazygit = {
					configure = true,
				},
				picker = {
					previewers = {
						git = {
							builtin = false,
							cmd = { "delta" },
						},
						diff = {
							builtin = false,
							cmd = { "delta" },
						},
					},
					sources = {
						explorer = {
							win = {
								list = {
									keys = {
										["<BS>"] = "explorer_up",
										["h"] = "explorer_close",
										["dd"] = "explorer_del",
										["d"] = { "" },
										["<leader>rn"] = "explorer_rename",
										["r"] = "",
										["y"] = { "" },
										["yy"] = { "explorer_yank", mode = { "n", "x" } },
										["u"] = "explorer_update",
									},
								},
							},
						},
					},
				},
				styles = {
					snacks_image = { border = "none" },
				},
			})
			require("snacks").indent.enable()
		end,
	},
	{
		"folke/zen-mode.nvim",
		keys = {
			{
				"<leader>z",
				":ZenMode<CR>",
				desc = "Toggle Zen Mode",
			},
		},
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 0, -- background (sidebars) fully black
				width = 100,
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
					cursorcolumn = false,
					foldcolumn = "0",
					list = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					laststatus = 0,
				},
				kitty = {
					enabled = true,
					font = "+3",
				},
			},
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		cmd = "HighlightColors",
		keys = {
			{
				"<leader>ks",
				mode = { "n" },
				":HighlightColors Toggle<CR>",
				desc = "Toggle showing colors",
			},
		},
		config = function(_, opts)
			local C = require("nvim-highlight-colors")
			C.setup(opts)
			C.turnOff() -- Immediately turn it off after loading, so that the first toggle command will actually turn it on
		end,
		opts = {
			render = "virtual",
			virtual_symbol = "◖███◗",
			virtual_symbol_prefix = " ← ",
			virtual_symbol_position = "eol",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>dd",
				function()
					require("harpoon"):list():remove()
				end,
				desc = "Remove from harpoon list",
			},
			{
				"<leader>da",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add to harpoon list",
			},
			{
				"<leader>ds",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Toggle harpoon list menu",
			},
			{
				"<leader>dj",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Select harpoon #1",
			},
			{
				"<leader>dk",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Select harpoon #2",
			},
			{
				"<leader>dl",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Select harpoon #3",
			},
			{
				"<leader>d;",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Select harpoon #4",
			},
			{
				"<leader>du",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Select harpoon #5",
			},
			{
				"<leader>di",
				function()
					require("harpoon"):list():select(6)
				end,
				desc = "Select harpoon #6",
			},
			{
				"<leader>do",
				function()
					require("harpoon"):list():select(7)
				end,
				desc = "Select harpoon #7",
			},
			{
				"<leader>dp",
				function()
					require("harpoon"):list():select(8)
				end,
				desc = "Select harpoon #8",
			},
			{
				"<leader>dn",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "Go to harpoon previous buffer",
			},
			{
				"<leader>dm",
				function()
					require("harpoon"):list():next()
				end,
				desc = "Go to harpoon next buffer",
			},
		},
		setup = true,
	},
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = {},
				session_lens = {},
			})
			vim.keymap.set("n", "<leader>op", "<cmd>AutoSession search<cr>", {
				noremap = true,
				desc = "Open project",
			})
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				drag_and_drop = {
					enabled = true,
					insert_mode = true,
				},
				relative_to_current_file = true,
				relative_template_path = true,
				dir_path = function()
					return "media/" .. vim.fn.expand("%:t:r")
				end,
				extension = "webp",
			},
			filetypes = {
				djot = {
					url_encode_path = false,
					template = "![$FILE_NAME_NO_EXT](./$FILE_PATH)$CURSOR",
					download_images = false,
				},
			},
		},
		keys = {
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
	{
		"y3owk1n/time-machine.nvim",
		version = "*",
		keys = {
			{
				"<leader>u",
				mode = { "n" },
				function()
					require("time-machine").actions.toggle()
				end,
				desc = "Undo history",
			},
		},
		opts = {
			native_diff_opts = {
				result_type = "unified",
			},
		},
	},
	{
		"echasnovski/mini.comment",
		opts = {
			mappings = {
				textobject = "ac",
			},
		},
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		opts = {
			keymaps = {
				useDefaults = true,
			},
		},
	},
	{
		"martineausimon/nvim-lilypond-suite",
		opts = {},
	},
}
