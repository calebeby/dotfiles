return {
	{
		"aaronik/treewalker.nvim",
		opts = {},
		cmd = "Treewalker",
	},
	{
		"nvimtools/hydra.nvim",
		dependencies = {},
		keys = {
			{
				"<Leader><Leader>",
				mode = { "n", "x" },
				function()
					local Hydra = require("hydra")

					local walker = Hydra({
						name = "Walker",
						mode = { "n", "x" },
						hint = [[
      _h_
    _j_   _k_
      _l_]],
						config = {},
						heads = {
							{
								"h",
								"<Cmd>Treewalker Left<CR>",
								{ desc = "outer" },
							},
							{
								"j",
								"<Cmd>Treewalker Down<CR>",
								{ desc = "next" },
							},
							{
								"k",
								"<Cmd>Treewalker Up<CR>",
								{ desc = "previous" },
							},
							{
								"l",
								"<Cmd>Treewalker Right<CR>",
								{ desc = "inner" },
							},
						},
					})
					walker:activate()
				end,
				desc = "Tree Walker (Hydra)",
			},
		},
	},
}
