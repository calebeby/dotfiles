return {
	{
		-- Formatter
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>F",
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
				typst = { "typstfmt" },
				zig = { "zigfmt" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettier",
				"prettierd",
				"biome",
				"typstfmt",
				"stylua",
			},
			auto_update = true,
		},
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "FileType",
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
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"ts_ls",
					"marksman",
					"tinymist",
					"zls",
					"denols",
					"basedpyright",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({ capabilities = capabilities })
					end,
					basedpyright = function()
						lspconfig.basedpyright.setup({
							capabilities = capabilities,
							filetypes = { "python" },
							settings = {
								basedpyright = {
									analysis = {
										autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										typeCheckingMode = "basic",
									},
								},
							},
						})
					end,
					marksman = function()
						lspconfig.marksman.setup({
							capabilities = capabilities,
							filetypes = { "markdown", "djot" },
						})
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
					denols = function()
						lspconfig.denols.setup({
							capabilities = capabilities,
							root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
							init_options = {
								lint = true,
								unstable = true,
								suggest = {
									imports = {
										hosts = {
											["https://deno.land"] = true,
										},
									},
								},
							},
						})
					end,
					ts_ls = function()
						lspconfig.ts_ls.setup({
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								vim.keymap.set("n", "<leader>ro", function()
									vim.lsp.buf.execute_command({
										command = "_typescript.organizeImports",
										arguments = { vim.fn.expand("%:p") },
									})
								end, { buffer = bufnr, remap = false })
							end,
							root_dir = function(filename, bufnr)
								local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.json")(filename)
								if denoRootDir then
									return nil
								end

								local rootDir = lspconfig.util.root_pattern(
									"tsconfig.json",
									"jsconfig.json",
									"package.json",
									".git"
								)(filename)
								if rootDir then
									return rootDir
								end
								return vim.fs.dirname(filename)
							end,
							single_file_support = false,
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
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"garymjr/nvim-snippets",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"octaltree/cmp-look",
			"hrsh7th/cmp-emoji",
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
						elseif vim.snippet.active({ direction = 1 }) then
							vim.schedule(function()
								vim.snippet.jump(1)
							end)
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
						elseif vim.snippet.active({ direction = -1 }) then
							vim.schedule(function()
								vim.snippet.jump(-1)
							end)
						else
							fallback()
						end
					end,
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = function()
						if not cmp.visible() then
							cmp.complete()
						end
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "snippets" },
					{ name = "emoji" },
				}, {
					{
						name = "buffer",
						keyword_length = 4,
					},
					{ name = "path" },
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
		"garymjr/nvim-snippets",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		opts = {},
	},
	{
		"chrisgrieser/nvim-scissors",
		dependencies = "nvim-telescope/telescope.nvim",
		opts = {
			snippetDir = "~/.config/new_neovim_config/snippets",
			jsonFormatter = "jq",
		},
		keys = {
			{
				"<leader>Se",
				mode = { "n" },
				function()
					require("scissors").editSnippet()
				end,
				desc = "Edit Snippets",
			},
			{
				"<leader>Sa",
				mode = { "n", "x" },
				function()
					require("scissors").addNewSnippet()
				end,
				desc = "Add New Snippet",
			},
		},
	},
	{
		"folke/trouble.nvim",
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
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=true<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=true<cr>",
				desc = "LSP Definitions / References / ... (Trouble)",
			},
		},
		opts = {
			auto_preview = false,
			win = {
				type = "split",
				position = "right",
				size = { width = 50 },
			},
			preview = {
				type = "float",
				relative = "cursor",
				size = {
					width = 49,
					height = 6,
				},
				border = "rounded",
				position = { 2, 0 },
			},
			throttle = {
				preview = { ms = 10, debounce = true },
			},
		},
	},
}
