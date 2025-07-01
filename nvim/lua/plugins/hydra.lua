return {
	{
		"gsuuon/tshjkl.nvim",
		opts = {
			keymaps = {
				toggle = "<leader><leader>",
			},
			marks = {
				parent = {
					virt_text = { { "h", "ModeMsg" } },
					virt_text_pos = "eol",
					hl_group = "",
				},
				child = {
					virt_text = { { "l", "ModeMsg" } },
					virt_text_pos = "eol",
				},
				prev = {
					virt_text = { { "k", "ModeMsg" } },
					virt_text_pos = "eol",
					hl_group = "CursorLine",
				},
				next = {
					virt_text = { { "j", "ModeMsg" } },
					virt_text_pos = "eol",
					hl_group = "CursorLine",
				},
			},
		},
	},
	{
		"aaronik/treewalker.nvim",
		opts = {
			highlight_group = "Visual",
			highlight = false,
		},
	},
	-- 	{
	-- 		"nvimtools/hydra.nvim",
	-- 		dependencies = {},
	-- 		keys = {
	-- 			{
	-- 				"<leader><leader>",
	-- 				mode = { "n", "x" },
	-- 				function()
	-- 					local Hydra = require("hydra")
	-- 					local ts_inc = require("nvim-treesitter.incremental_selection")
	-- 					local walker = Hydra({
	-- 						name = "Walker",
	-- 						mode = { "n", "x" },
	-- 						hint = [[
	--         _k_                _K_
	-- Move: _h_   _l_      Swap: _H_   _L_
	--         _j_                _J_]],
	-- 						config = {
	-- 							on_key = function()
	-- 								-- ts_inc.init_selection()
	-- 							end,
	-- 						},
	-- 						heads = {
	-- 							{ "h", "<cmd>Treewalker Left<cr>", { desc = "outer" } },
	-- 							{ "j", "<cmd>Treewalker Down<cr>", { desc = "next" } },
	-- 							{ "k", "<cmd>Treewalker Up<cr>", { desc = "previous" } },
	-- 							{ "l", "<cmd>Treewalker Right<cr>", { desc = "inner" } },
	-- 							{ "J", "<cmd>Treewalker SwapDown<cr>", { desc = "swap next" } },
	-- 							{ "K", "<cmd>Treewalker SwapUp<cr>", { desc = "swap previous" } },
	-- 							{ "H", "<cmd>Treewalker SwapLeft<cr>", { desc = "swap left" } },
	-- 							{ "L", "<cmd>Treewalker SwapRight<cr>", { desc = "swap right" } },
	-- 						},
	-- 					})
	--
	-- 					walker:activate()
	-- 				end,
	-- 				desc = "Tree Walker (Hydra)",
	-- 			},
	-- 		},
	-- 	},
}
