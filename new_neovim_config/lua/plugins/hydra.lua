return {
	{
		"nvimtools/hydra.nvim",
		dependencies = {
			"ziontee113/syntax-tree-surfer",
		},
		config = function()
			local Hydra = require("hydra")
			local sts = require("syntax-tree-surfer")

			local select_if_no_selection = function()
				local mode = vim.api.nvim_get_mode().mode
				local is_visual = mode == "v" or mode == "V" or mode == "^V"
				if not is_visual then
					sts.select_current_node()
				end
			end

			local walker = Hydra({
				name = "Walker",
				mode = { "n", "x" },
				-- hint = [[  ]],
				config = {},
				heads = {
					{
						"h",
						function()
							sts.surf("parent", "visual")
						end,
						{ desc = "Nav to parent node" },
					},
					{
						"l",
						function()
							sts.surf("child", "visual")
						end,
						{ desc = "Nav to child node" },
					},
					{
						"k",
						function()
							sts.surf("prev", "visual")
						end,
						{ desc = "Nav to previous node" },
					},
					{
						"j",
						function()
							sts.surf("next", "visual")
						end,
						{ desc = "Nav to next node" },
					},
				},
			})

			vim.keymap.set({ "n", "x" }, "<Leader>n", function()
				select_if_no_selection()
				walker:activate()
			end)
		end,
	},
}
