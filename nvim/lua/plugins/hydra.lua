return {
	{
		"calebeby/tshjkl.nvim",
		dir = "~/Programming/calebeby/tshjkl.nvim",
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
					hl_group = "CETSHJKLNavigation",
				},
				next = {
					virt_text = { { "j", "ModeMsg" } },
					virt_text_pos = "eol",
					hl_group = "CETSHJKLNavigation",
				},
			},
		},
	},
}
