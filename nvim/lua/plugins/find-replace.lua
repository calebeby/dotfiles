vim.keymap.set("n", "<leader>ff", function()
	require("snacks").picker("grep")
end, { desc = "Find/Replace in Project (snacks grep)" })

return {
	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>fp",
				function()
					require("grug-far").open({ windowCreationCommand = "tab split" })
				end,
				desc = "Find/Replace in Project",
			},
		},
		opts = {
			debounceMs = 50,
			startInInsertMode = false,
			keymaps = {
				close = { n = "q", desc = "Quit" },
			},
		},
	},
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		opts = {},
		keys = {
			{
				"<leader>fl",
				mode = { "n", "v" },
				function()
					require("rip-substitute").setup({ prefill = { normal = false } })
					require("rip-substitute").sub({ range = 0, args = "" })
				end,
				desc = "Find and replace (this file/local) (ripgrep)",
			},
			{
				"<c-f>",
				mode = { "n", "v" },
				function()
					require("rip-substitute").setup({ prefill = { normal = "cursorWord" } })
					require("rip-substitute").sub({ range = 0, args = "" })
				end,
				desc = "Find and replace (PREFILL word) (this file/local) (ripgrep)",
			},
		},
	},
}
