return {
	{
		"drybalka/tree-climber.nvim",
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
					local tc = require("tree-climber")

					local opts = {
						highlight = true,
						higroup = "SnippetTabstop",
					}

					local function make_handler(func)
						return function()
							pcall(func, opts)
							tc.highlight_node(opts)
						end
					end

					local walker = Hydra({
						name = "Walker",
						mode = { "n", "x" },
						hint = [[
        _k_              _K_
Move: _h_   _l_      Swap:
        _j_              _J_]],
						config = {
							on_exit = function()
								pcall(tc.select_node, opts)
							end,
						},
						heads = {
							{ "h", make_handler(tc.goto_parent), { desc = "outer" } },
							{ "j", make_handler(tc.goto_next), { desc = "next" } },
							{ "k", make_handler(tc.goto_prev), { desc = "previous" } },
							{ "l", make_handler(tc.goto_child), { desc = "inner" } },
							{ "v", function() end, { desc = "Visual Selection", exit = true } },
							{ "J", make_handler(tc.swap_next), { desc = "next" } },
							{ "K", make_handler(tc.swap_prev), { desc = "previous" } },
						},
					})

					pcall(tc.highlight_node, opts)
					walker:activate()
				end,
				desc = "Tree Walker (Hydra)",
			},
		},
	},
}
