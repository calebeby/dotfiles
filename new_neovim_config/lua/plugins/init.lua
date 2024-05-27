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
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			enhanced_diff_hl = true,
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "" },
					change = { text = "" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = true,
				preview_config = {
					border = "none",
					row = 1,
					col = 0,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Previous hunk" })

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hx", gitsigns.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage selection" })
					map("v", "<leader>hx", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset selection" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo hunk staging" })
					map("n", "<leader>hX", gitsigns.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hb", gitsigns.blame_line, { desc = "Show git blame for line" })
					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Vimdiff unstaged changes in file" })
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Vimdiff uncommitted changes in file" })
					map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle showing unstaged deleted lines" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "hunk" })
				end,
			})
		end,
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
		-- Formatter
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				rust = { "rustfmt" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				event = "VeryLazy",
				opts = {
					ensure_installed = {
						"prettier",
						"prettierd",
						"biome",
						"typst-lsp",
						"stylua",
					},
					auto_update = true,
				},
			},
		},
		config = function()
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
					},
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason").setup()
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup({
				ensure_installed = { "rust_analyzer", "tsserver" },
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({ capabilities = capabilities })
					end,
					lua_ls = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
					rust_analyzer = function()
						lspconfig.rust_analyzer.setup({
							capabilities = capabilities,
							settings = {
								["rust-analyzer"] = {
									checkOnSave = {
										command = "clippy",
									},
								},
							},
						})
					end,
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
					vim.api.nvim_buf_set_keymap(0, "n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
					vim.api.nvim_buf_set_keymap(0, "n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
					vim.api.nvim_buf_set_keymap(0, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
					vim.api.nvim_buf_set_keymap(0, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"octaltree/cmp-look",
			"neovim/nvim-lspconfig",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<c-j>"] = function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
					["<s-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = function(fallback)
						if cmp.visible() then
							fallback()
						else
							cmp.select_next_item()
						end
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "neorg" },
				}, {
					{
						name = "buffer",
						keyword_length = 4,
					},
				}, {
					{
						name = "look",
						keyword_length = 5,
						option = {
							convert_case = true,
							loud = true,
						},
					},
				}),
				formatting = {
					format = require("lspkind").cmp_format({ mode = "symbol" }),
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		branch = "dev",
		cmd = { "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=true<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=true<cr>",
				desc = "LSP Definitions / References / ... (Trouble)",
			},
		},
		opts = {
			win = {
				type = "split",
				position = "right",
				size = { width = 70 },
			},
			preview = {
				type = "float",
				relative = "cursor",
				size = {
					width = 69,
					height = 8,
				},
				border = "rounded",
				position = { 2, 0 },
			},
			throttle = {
				preview = { ms = 10, debounce = true },
			},
		},
	},
	-- Colors/Themes
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
	{
		"echasnovski/mini.base16",
		version = false,
		enabled = false,
		opts = {
			palette = {
				base00 = "#2d2d2d",
				base01 = "#393939",
				base02 = "#515151",
				base03 = "#999999",
				base04 = "#b4b7b4",
				base05 = "#cccccc",
				base06 = "#e0e0e0",
				base07 = "#ffffff",
				base08 = "#f2777a",
				base09 = "#f99157",
				base0A = "#ffcc66",
				base0B = "#99cc99",
				base0C = "#66cccc",
				base0D = "#6699cc",
				base0E = "#cc99cc",
				base0F = "#a3685a",
			},
		},
	},
	{
		"rebelot/kanagawa.nvim",
		-- config = function()
		-- 	vim.cmd([[colorscheme kanagawa]])
		-- end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- config = function ()
		--   vim.cmd[[colorscheme rose-pine-main]]
		-- end
	},
	{
		"EdenEast/nightfox.nvim",
		-- config = function()
		-- 	vim.cmd([[colorscheme duskfox]])
		-- end,
	},
	{
		"sainnhe/everforest",
		-- config = function()
		-- 	vim.cmd([[colorscheme everforest]])
		-- end,
	},
	{
		"sainnhe/sonokai",
		-- config = function()
		-- 	vim.cmd([[colorscheme sonokai]])
		-- end,
	},
	{
		"navarasu/onedark.nvim",
		-- config = function()
		-- 	vim.cmd([[colorscheme onedark]])
		-- end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"<Leader>m",
				function()
					require("treesj").toggle()
				end,
				desc = "Toggle syntax collapse/expand (treesj)",
			},
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 250,
		},
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
				search_method = "cover_or_next",
			})

			-- Remap adding surrounding to Visual mode selection
			-- vim.keymap.del("x", "ys")
			-- vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = "*",
		opts = {},
	},
	{
		-- Little hint next to closing brackets showing what they correspond to
		"code-biscuits/nvim-biscuits",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("nvim-biscuits").setup({
				cursor_line_only = true,
				default_config = {
					prefix_string = " « ",
					max_length = 50,
				},
				language_config = {
					norg = {
						disabled = true,
					},
					markdown = {
						disabled = true,
					},
					help = {
						disabled = true,
					},
					vimdoc = {
						disabled = true,
					},
				},
			})
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "BiscuitColor", { link = "Comment" })
			end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"typescript",
					"javascript",
					"tsx",
					"jsdoc",
					"regex",
					"c",
					"cpp",
					"rust",
					"svelte",
					"html",
					"css",
					"json",
					"astro",
					"markdown",
					"zig",
					"lua",
					"vim",
					"yaml",
					"bash",
					"sql",
					"djot",
					"typst",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				-- Expanding selection
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["aF"] = "@call.outer",
							["iF"] = "@call.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["a,"] = "@parameter.outer",
							["i,"] = "@parameter.inner",
						},
					},
					swap = {
						-- enable = true,
						-- swap_next = {
						-- 	["<Leader>l"] = "@parameter.inner",
						-- },
						-- swap_previous = {
						-- 	["<Leader>h"] = "@parameter.inner",
						-- },
					},
				},
			})

			require("treesitter-context").setup({
				enable = true,
				line_numbers = true,
				mode = "topline",
			})
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end,
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
		"danilamihailov/beacon.nvim",
		config = function()
			vim.g.beacon_timeout = 200
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "Beacon", { link = "Search" })
			end)
		end,
	},
	{
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.6",
			cmd = { "Telescope" },
			dependencies = {
				"nvim-lua/plenary.nvim",
				"debugloop/telescope-undo.nvim",
				"natecraddock/telescope-zf-native.nvim",
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
						undo = {
							use_delta = false,
							-- side_by_side = true,
							diff_context_lines = 5,
							mappings = {
								i = {
									["<cr>"] = require("telescope-undo.actions").restore,
								},
							},
						},
					},
				})

				require("telescope").load_extension("undo")
				require("telescope").load_extension("zf-native")
			end,
		},
	},
	{
		"vhyrro/luarocks.nvim",
		-- priority = 1001,
		lazy = true,
		opts = {
			rocks = { "magick" },
		},
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
