return {
	{
		"nvimtools/hydra.nvim",
		dependencies = {
			{
				"ziontee113/syntax-tree-surfer",
				dir = "~/Programming/calebeby/syntax-tree-surfer",
			},
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
							sts.surf("prev", "visual")
						end,
						{ desc = "Nav to previous node" },
					},
					{
						"l",
						function()
							sts.surf("next", "visual")
						end,
						{ desc = "Nav to next node" },
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
					{
						"<CR>",
						function()
							sts.surf("child", "visual")
						end,
						{ desc = "Nav to child node" },
					},
					{
						"<space>",
						function()
							sts.surf("parent", "visual")
						end,
						{ desc = "Nav to parent node" },
					},
					{
						"H",
						function()
							sts.surf("prev", "visual", true)
						end,
						{ desc = "Move to previous node" },
					},
					{
						"L",
						function()
							sts.surf("next", "visual", true)
						end,
						{ desc = "Move to next node" },
					},
					{
						"K",
						function()
							sts.surf("prev", "visual", true)
						end,
						{ desc = "Move to previous node" },
					},
					{
						"J",
						function()
							sts.surf("next", "visual", true)
						end,
						{ desc = "Move to next node" },
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
