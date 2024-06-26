return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		cmd = { "Telescope" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"natecraddock/telescope-zf-native.nvim",
			"zk-org/zk-nvim",
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
			require("telescope").load_extension("zk")
		end,
	},
}
