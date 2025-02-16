return {
	{
		"drybalka/tree-climber.nvim",
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

					local opts = {
						highlight = true,
						higroup = "CursorLine",
					}

					local walker = Hydra({
						name = "Walker",
						mode = { "n", "x" },
						hint = [[
        _k_              _K_
Move: _h_   _l_      Swap:
        _j_              _J_]],
						config = {
							on_exit = function()
								require("tree-climber").select_node(opts)
							end,
						},
						heads = {
							{
								"h",
								function()
									require("tree-climber").goto_parent(opts)
								end,
								{ desc = "outer" },
							},
							{
								"j",
								function()
									require("tree-climber").goto_next(opts)
								end,
								{ desc = "next" },
							},
							{
								"k",
								function()
									require("tree-climber").goto_prev(opts)
								end,
								{ desc = "previous" },
							},
							{
								"l",
								function()
									require("tree-climber").goto_child(opts)
								end,
								{ desc = "inner" },
							},
							{
								"v",
								function() end,
								{ desc = "Visual Selection", exit = true },
							},
							{
								"J",
								function()
									require("tree-climber").swap_next(opts)
									require("tree-climber").highlight_node(opts)
								end,
								{ desc = "next" },
							},
							{
								"K",
								function()
									require("tree-climber").swap_prev(opts)
									require("tree-climber").highlight_node(opts)
								end,
								{ desc = "previous" },
							},
						},
					})
					require("tree-climber").highlight_node(opts)
					walker:activate()
				end,
				desc = "Tree Walker (Hydra)",
			},
		},
	},
}
