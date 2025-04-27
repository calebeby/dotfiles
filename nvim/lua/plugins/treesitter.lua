local highlight_hook = function(update_color)
	vim.api.nvim_create_autocmd("ColorScheme", { callback = update_color })
	update_color()
end

return {
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
		"stevearc/aerial.nvim",
		keys = {
			{
				"<leader>xa",
				"<cmd>AerialToggle!<CR>",
				desc = "Outline (Aerial)",
			},
			{
				"<leader>n",
				"<cmd>Telescope aerial<CR>",
				desc = "Symbol Search (Treesitter)",
			},
		},
		opts = {
			show_guides = true,
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				-- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				-- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		-- Little hint next to closing brackets showing what they correspond to
		"code-biscuits/nvim-biscuits",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("nvim-biscuits").setup({
				cursor_line_only = true,
				default_config = {
					prefix_string = " « ",
					max_length = 50,
				},
				language_config = {
					norg = { disabled = true },
					markdown = { disabled = true },
					djot = { disabled = true },
					help = { disabled = true },
					vimdoc = { disabled = true },
					typst = { disabled = true },
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
					"query", -- for treesitter queries
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
					"lua",
					"vim",
					"vimdoc",
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
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ac"] = "@comment.outer",
							["ic"] = "@comment.inner",
						},
					},
				},
			})

			require("treesitter-context").setup({
				enable = true,
				line_numbers = true,
				mode = "topline",
				min_window_height = 15,
				max_lines = 5,
			})
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end,
	},
}
