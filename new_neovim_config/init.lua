--- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--- MY OWN SETUP

-- Autocompletion should be case-insensitive
vim.opt.ignorecase = true

-- Reload files changed outside of neovim
vim.opt.autoread = true
vim.opt.updatetime = 10
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	command = [[checktime]],
})

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.termguicolors = true

-- Permanent undo
vim.opt.undodir = "~/.vimdid"

-- Use system clipboard (requires xsel)
vim.opt.clipboard = "unnamedplus"

-- New windows down and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tab characters are 2 spaces wide
vim.opt.tabstop = 2

-- When indenting with << and >> use 2 spaces width
vim.opt.shiftwidth = 2

-- When pressing tab, use spaces
vim.opt.expandtab = true

-- Guide for max line width
vim.opt.colorcolumn = { 80 }

-- Quit
vim.keymap.set("n", "<c-q>", ":qall<CR>", { silent = true })

-- Clear search by pressing <esc>
vim.keymap.set("n", "<esc>", ":noh<CR><ESC>", { silent = true })

-- Briefly highlight yanked text
local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

-- Use space as leader
vim.g.mapleader = " "

require("lazy").setup("plugins")

-- Window mappings
vim.keymap.set("n", "<Leader>w", "<c-w>")
vim.keymap.set("n", "<a-h>", "<c-w>h")
vim.keymap.set("n", "<a-j>", "<c-w>j")
vim.keymap.set("n", "<a-k>", "<c-w>k")
vim.keymap.set("n", "<a-l>", "<c-w>l")
vim.keymap.set("t", "<a-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<a-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<a-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<a-l>", "<c-\\><c-n><c-w>l")

-- Save file
vim.keymap.set("n", "<Leader>s", ":write<CR>", { silent = true })

-- Go to definition and similar
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", { silent = true })
vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", { silent = true })
vim.keymap.set("n", "gD", ":Telescope lsp_type_definitions<CR>", { silent = true })

-- Git
vim.keymap.set("n", "gs", function()
	require("neogit").open()
end, { desc = "Open Neogit" })

-- Change colorscheme
vim.keymap.set("n", "<Leader>kt", ":Telescope colorscheme<CR>", { silent = true })

vim.keymap.set("n", "<leader>o", ":Telescope find_files<CR>", { silent = true })

-- alt-up alt-down for moving lines up or down
vim.keymap.set("n", "<a-up>", ":m .-2<CR>", { silent = true })
vim.keymap.set("n", "<a-down>", ":m .+1<CR>", { silent = true })
vim.keymap.set("i", "<a-up>", ":m .-2<CR>i", { silent = true })
vim.keymap.set("i", "<a-down>", ":m .+1<CR>i", { silent = true })
vim.keymap.set("v", "<a-up>", ":m '<-2<CR>gv", { silent = true })
vim.keymap.set("v", "<a-down>", ":m '>+1<CR>gv", { silent = true, remap = true })

-- Comment toggles
vim.keymap.set("n", "<c-/>", "gcc", { remap = true })
vim.keymap.set("v", "<c-/>", "gc gv", { remap = true })
vim.keymap.set("i", "<c-/>", "<ESC>gcc gi", { remap = true })
