return {
	{
		-- Formatter
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				formatters = {
					djotfmt = {
						command = "bilbo",
						stdin = false, -- Write a temp file, format it in-place, then use the buffer to apply the format patch
						args = { "fmt", "$FILENAME" },
					},
					prettier = {
						require_cwd = true,
						cwd = require("conform.util").root_file({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.yaml",
							".prettierrc.json5",
							".prettierrc.js",
							".prettierrc.cjs",
							".prettierrc.mjs",
							".prettierrc.toml",
							"prettier.config.js",
							"prettier.config.cjs",
							"prettier.config.mjs",
						}),
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					typst = { "typstyle" },
					djot = { "djotfmt", "injected" },
					javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
					typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
					rust = { "rustfmt" },
					zig = { "zigfmt" },
				},
				format_on_save = { timeout_ms = 1500, lsp_fallback = true },
			})
		end,
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
				"stylua",
				"typstyle",
				"harper-ls",
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

			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})

			vim.lsp.config("harper_ls", { settings = {} })

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			})

			vim.lsp.config("denols", {
				root_dir = function(bufnr, cb)
					local filename = vim.api.nvim_buf_get_name(bufnr)
					local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename)
					if denoRootDir then
						cb(denoRootDir)
					end
				end,
			})

			vim.lsp.config("ts_ls", {
				root_dir = function(bufnr, cb)
					local filename = vim.api.nvim_buf_get_name(bufnr)
					local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename)
					-- Don't call the callback if you don't want the server to start.
					-- For deno projects, don't start ts_ls.
					if not denoRootDir then
						local rootDir =
							lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(
								filename
							)
						if rootDir then
							cb(rootDir)
						else
							cb(vim.fs.dirname(filename))
						end
					end
				end,
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"ts_ls",
					"marksman",
					"tinymist",
					"zls",
					"denols",
					"basedpyright",
					"biome",
				},
				automatic_enable = true,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
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
					{ name = "snippets", keyword_length = 2 },
					{ name = "emoji", keyword_length = 2 },
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
			snippetDir = "~/dotfiles/nvim/snippets",
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
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>rr",
				desc = "Select refactor",
				mode = { "n", "x" },
				function()
					require("refactoring").select_refactor()
				end,
			},
			{
				"<leader>rp",
				desc = "Add print statement",
				mode = { "n" },
				function()
					require("refactoring").debug.print_var()
				end,
			},
			{
				"<leader>rP",
				desc = "Remove all generated print statements",
				mode = { "n" },
				function()
					require("refactoring").debug.cleanup({})
				end,
			},
		},
		opts = {},
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
