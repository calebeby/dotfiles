-- Allows updating highlights initially and when color scheme is changed/replaced
local highlight_hook = function(update_color)
	vim.api.nvim_create_autocmd("ColorScheme", { callback = update_color })
	update_color()
end

return {
	"nvim-tree/nvim-web-devicons",
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "<CR>", -- automatically close after selecting a file
					go_out = "h",
					go_out_plus = "<ESC>",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
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
					require("flash").remote()
				end,
				desc = "Remote (Flash)",
			},
			-- {
			-- 	"R", -- Keybinding conflicts with substitute.nvim
			-- 	mode = { "o" },
			-- 	function()
			-- 		require("flash").treesitter_search()
			-- 	end,
			-- 	desc = "TS node (Flash)",
			-- },
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
		config = function()
			require("flash").setup()
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "FlashLabel", { link = "IncSearch" })
			end)
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		version = false,
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			local wk = require("which-key")
			wk.register({
				g = { name = "+git" },
				h = { name = "+hunk" },
				c = { name = "+context" },
				k = { name = "+preferences" },
				t = { name = "+toggle" },
				x = { name = "+diagnostics" },
			}, { prefix = "<Leader>" })
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "ys",
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
		version = "*",
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
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>f",
				function()
					require("grug-far").grug_far({})
				end,
				desc = "Find/Replace in Project",
			},
			{
				"<c-f>",
				function()
					require("grug-far").grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
				desc = "Find/Replace in Project (word under cursor)",
			},
			{
				"<c-f>",
				mode = { "v" },
				function()
					require("grug-far").with_visual_selection({})
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
				backdrop = 0.55,
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
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		keys = {
			{
				"<c-`>",
				mode = { "n", "t" },
				function()
					require("toggleterm").toggle_command("direction=float")
				end,
				desc = "Toggle Terminal",
			},
		},
		opts = {},
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
			vim.keymap.set("n", "<leader>O", require("auto-session.session-lens").search_session, {
				noremap = true,
			}, { desc = "Open project" })
		end,
	},
}
