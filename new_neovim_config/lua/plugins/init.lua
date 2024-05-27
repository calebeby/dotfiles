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
		opts = {
			mappings = {
				close = "<ESC>",
				go_in = "l",
				go_in_plus = "<CR>",
				go_out = "h",
				go_out_plus = "H",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		},
	},
	{
		-- Motion plugin like leap/sneak/easymotion/lightspeed/hop
		"folke/flash.nvim",
		event = "VeryLazy",
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
			{
				"R",
				mode = { "o" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "TS node (Flash)",
			},
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
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini.statusline",
		version = "*",
		opts = {
			set_vim_settings = false,
		},
	},
	{
		"echasnovski/mini.tabline",
		version = "*",
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
		config = function()
			local sub = require("substitute")
			sub.setup({ highlight_substituted_text = { enabled = false } })
			vim.keymap.set("n", "R", sub.operator, { noremap = true })
			vim.keymap.set("n", "RR", sub.line, { noremap = true })
			vim.keymap.set("x", "R", sub.visual, { noremap = true })
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		lazy = true,
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"nvim-neorg/neorg",
		dependencies = {
			"vhyrro/luarocks.nvim",
			"nvim-neorg/neorg-telescope",
			{
				"3rd/image.nvim",
				dependencies = { "vhyrro/luarocks.nvim" },
				config = true,
			},
		},
		version = "*",
		ft = "norg",
		cmd = { "Neorg" },
		config = function()
			require("telescope").load_extension("neorg")

			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								["test-neorg"] = "~/test-neorg",
							},
							default_workspace = "test-neorg",
						},
					},
					["core.integrations.image"] = {},
					["core.integrations.telescope"] = {},
					["core.latex.renderer"] = {
						config = {
							render_on_enter = true,
						},
					},
					["core.export"] = {},
					["core.itero"] = {},
					["core.ui.calendar"] = {},
				},
			})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2

			local neorg_callbacks = require("neorg.core.callbacks")

			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				-- Map all the below keybinds only when the "norg" mode is active
				keybinds.map_event_to_mode("norg", {
					n = { -- Bind keys in normal mode
						{ "<C-s>", "core.integrations.telescope.find_linkable" },
					},

					i = { -- Bind in insert mode
						{ "<C-l>", "core.integrations.telescope.insert_link" },
					},
				}, {
					silent = true,
					noremap = true,
				})
			end)
		end,
	},
}
