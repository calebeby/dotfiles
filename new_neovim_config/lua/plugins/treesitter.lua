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
}
