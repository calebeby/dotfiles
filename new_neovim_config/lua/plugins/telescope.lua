return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		cmd = { "Telescope" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"zk-org/zk-nvim",
			"protex/better-digraphs.nvim",
		},
		keys = {
			{
				"<c-k><c-k>",
				function()
					require("better-digraphs").digraphs("insert")
				end,
				mode = "i",
				desc = "Insert digraph",
			},
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
					aerial = {},
					undo = {
						use_delta = false,
						vim_diff_opts = {
							ctxlen = 5,
						},
						mappings = {
							i = {
								["<cr>"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			})

			require("telescope").load_extension("undo")
			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("zk")
		end,
	},
}
