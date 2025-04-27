return {
	{
		dir = "~/dotfiles/vim-colors",
		name = "colors",
		config = function()
			vim.cmd([[colorscheme one_dark]])
		end,
	},
}
