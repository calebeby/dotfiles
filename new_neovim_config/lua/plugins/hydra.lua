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
								"<Cmd>Treewalker Left<CR>zz",
								{ desc = "outer" },
							},
							{
								"j",
								"<Cmd>Treewalker Down<CR>zz",
								{ desc = "next" },
							},
							{
								"k",
								"<Cmd>Treewalker Up<CR>zz",
								{ desc = "previous" },
							},
							{
								"l",
								"<Cmd>Treewalker Right<CR>zz",
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
