return {
	"nvim-tree/nvim-web-devicons",
	{
		"stevearc/oil.nvim",
		opts = { skip_confirm_for_simple_edits = true },
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		config = true,
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
			use_icons = false,
			enhanced_diff_hl = true,
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
		opts = {},
	},
	{
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
					{ name = "soippets" },
				}, {
					{ name = "nvim_lsp" },
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
				experimental = {
					-- ghost_text = true,
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
	-- Colors
	{
		"folke/tokyonight.nvim",
		-- config = function ()
		--   vim.cmd[[colorscheme tokyonight]]
		-- end
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
		-- config = function ()
		--   vim.cmd[[colorscheme kanagawa]]
		-- end
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
		config = function()
			vim.cmd([[colorscheme duskfox]])
		end,
	},
	{
		"sainnhe/everforest",
		config = function()
			-- vim.cmd[[colorscheme everforest]]
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = { "<Leader>m" },
		config = function()
			local treesj = require("treesj")
			treesj.setup({
				use_default_keymaps = false,
				max_join_length = 250,
			})
			vim.keymap.set("n", "<Leader>m", treesj.toggle, { desc = "Toggle collapsed/expaned syntax (treesj)" })
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini.bracketed",
		version = "*",
		opts = {},
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
					"norg",
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
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["a,"] = "@parameter.outer",
							["i,"] = "@parameter.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<Leader>l"] = "@parameter.inner",
						},
						swap_previous = {
							["<Leader>h"] = "@parameter.inner",
						},
					},
				},
			})

			require("treesitter-context").setup({
				enable = true,
				line_numbers = true,
				mode = "topline",
			})
		end,
	},
	{
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.6",
			cmd = { "Telescope" },
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
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
						["ui-select"] = {
							require("telescope.themes").get_dropdown({}),
						},
						undo = {
							side_by_side = true,
							diff_context_lines = 5,
							mappings = {
								i = {
									["<cr>"] = require("telescope-undo.actions").restore,
								},
							},
						},
					},
				})

				require("telescope").load_extension("ui-select")
				require("telescope").load_extension("undo")
				require("telescope").load_extension("zf-native")
			end,
		},
	},
	-- {
	--   "vhyrro/luarocks.nvim",
	--   priority = 1000,
	--   config = true,
	-- },
	{
		"nvim-neorg/neorg",
		dependencies = {
			{
				"luarocks.nvim",
				config = true,
			},
			"nvim-neorg/neorg-telescope",
		},
		version = "*",
		ft = "norg",
		config = function()
			require("telescope").load_extension("neorg")
		end,
	},
}