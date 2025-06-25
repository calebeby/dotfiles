return {
	{
		"aaronik/treewalker.nvim",
		opts = {
			highlight_group = "Visual",
		},
	},
	{
		"nvimtools/hydra.nvim",
		dependencies = {},
		keys = {
			{
				"<leader><leader>",
				mode = { "n", "x" },
				function()
					local Hydra = require("hydra")
					local walker = Hydra({
						name = "Walker",
						mode = { "n", "x" },
						hint = [[
        _k_                _K_
Move: _h_   _l_      Swap: _H_   _L_
        _j_                _J_]],
						config = {},
						heads = {
							{ "h", "<cmd>Treewalker Left<cr>", { desc = "outer" } },
							{ "j", "<cmd>Treewalker Down<cr>", { desc = "next" } },
							{ "k", "<cmd>Treewalker Up<cr>", { desc = "previous" } },
							{ "l", "<cmd>Treewalker Right<cr>", { desc = "inner" } },
							{ "J", "<cmd>Treewalker SwapDown<cr>", { desc = "swap next" } },
							{ "K", "<cmd>Treewalker SwapUp<cr>", { desc = "swap previous" } },
							{ "H", "<cmd>Treewalker SwapLeft<cr>", { desc = "swap left" } },
							{ "L", "<cmd>Treewalker SwapRight<cr>", { desc = "swap right" } },
						},
					})

					walker:activate()
				end,
				desc = "Tree Walker (Hydra)",
			},
		},
	},
}
