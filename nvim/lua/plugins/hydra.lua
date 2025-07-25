return {
	-- {
	-- 	"gsuuon/tshjkl.nvim",
	-- 	opts = {
	-- 		keymaps = {
	-- 			toggle = "<leader><leader>",
	-- 		},
	-- 		marks = {
	-- 			parent = {
	-- 				virt_text = { { "h", "ModeMsg" } },
	-- 				virt_text_pos = "eol",
	-- 				hl_group = "",
	-- 			},
	-- 			child = {
	-- 				virt_text = { { "l", "ModeMsg" } },
	-- 				virt_text_pos = "eol",
	-- 			},
	-- 			prev = {
	-- 				virt_text = { { "k", "ModeMsg" } },
	-- 				virt_text_pos = "eol",
	-- 				hl_group = "CursorLine",
	-- 			},
	-- 			next = {
	-- 				virt_text = { { "j", "ModeMsg" } },
	-- 				virt_text_pos = "eol",
	-- 				hl_group = "CursorLine",
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"nvimtools/hydra.nvim",
		dependencies = {
			{
				"aaronik/treewalker.nvim",
				opts = { select = true },
			},
		},
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
						heads = {
							{ "j", "<cmd>Treewalker Down<cr>", { desc = "next" } },
							{ "h", "<cmd>Treewalker Left<cr>", { desc = "outer" } },
							{ "k", "<cmd>Treewalker Up<cr>", { desc = "previous" } },
							{ "J", "<cmd>Treewalker SwapDown<cr>", { desc = "swap next" } },
							{ "l", "<cmd>Treewalker Right<cr>", { desc = "inner" } },
							{ "K", "<cmd>Treewalker SwapUp<cr>", { desc = "swap previous" } },
							{ "H", "<cmd>Treewalker SwapLeft<cr>", { desc = "swap left" } },
							{ "L", "<cmd>Treewalker SwapRight<cr>", { desc = "swap right" } },
						},
					})

					-- Select current node at cursor
					local target = require("treewalker.nodes").get_current()
					local row = require("treewalker.nodes").get_srow(target)
					if target then
						require("treewalker.operations").jump(target, row)
					end
					walker:activate()
				end,
				desc = "Tree Walker (Hydra)",
			},
		},
	},
}
