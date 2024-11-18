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
vim.api.nvim_create_autocmd("CursorHold", {
	command = [[checktime]],
})

vim.opt.spelllang = "en_us"

-- Mostly used for which-key but this also affects other things
vim.opt.timeout = true
vim.opt.timeoutlen = 200

-- Don't show -- INSERT -- at the bottom (since there is statusline)
vim.opt.showmode = false
-- Hide ex mode (command line) when not in use
vim.opt.cmdheight = 0
-- Use a single global statusline at the very bottom instead of one per window
vim.opt.laststatus = 3

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.termguicolors = true

-- Disable netrw (default folder viewer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Permanent undo
vim.opt.undodir = vim.fn.expand("~/.vimdid")
vim.opt.undofile = true

-- Use system clipboard (requires xsel)
vim.opt.clipboard = "unnamedplus"

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2

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
vim.opt.colorcolumn = { 80, 100, 120 }

-- Guide for max line width
vim.opt.signcolumn = "number"

-- Better diffs in diff mode
vim.opt.diffopt:append("linematch:50")

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

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldtext = ""
vim.o.fillchars = [[fold: ]]

vim.o.list = true
vim.o.listchars = [[trail:·,tab:  ]]

vim.filetype.add({
	extension = {
		png = "image",
		jpg = "image",
		jpeg = "image",
		webp = "image",
		avif = "image",
		mp4 = "video",
		djot = "djot",
		dj = "djot",
		docx = "docx",
		doc = "doc",
		pptx = "pptx",
		ppt = "ppt",
		xls = "xls",
		xlsx = "xlsx",
		odt = "odt",
		ods = "ods",
		odp = "odp",
		xopp = "xopp",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst" },
	group = vim.api.nvim_create_augroup("typstoptions", {}),
	callback = function()
		vim.opt_local.commentstring = "// %s"
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("termoptions", {}),
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "djot" },
	group = vim.api.nvim_create_augroup("djotoptions", { clear = true }),
	callback = function()
		vim.opt_local.commentstring = "{% %s %}"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst", "markdown", "djot" },
	group = vim.api.nvim_create_augroup("prose_only_settings", { clear = true }),
	callback = function()
		vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true })
		vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true })
		vim.keymap.set({ "n", "x" }, "0", "g0", { buffer = true })
		vim.keymap.set({ "n", "x" }, "$", "g$", { buffer = true })

		vim.opt_local.linebreak = true
		vim.opt_local.textwidth = 100 -- Auto-insert line breaks in typed text (while typing in insert mode)
		vim.opt_local.showbreak = "→ "
		vim.opt_local.breakindent = true
		vim.opt_local.spell = true
	end,
})

vim.g.zipPlugin_ext =
	"*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx,*.epub"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "pdf", "docx", "doc", "pptx", "ppt", "xls", "xlsx", "image", "video", "odt", "ods", "odp", "xopp" },
	group = vim.api.nvim_create_augroup("binary_files_external", { clear = true }),
	callback = function()
		-- Delete this buffer automatically when it is hidden (not shown in a window)
		vim.opt_local.bufhidden = "delete"
		if vim.bo.filetype == "xopp" then
			-- Could not get the filetype registered in xdg-mime correctly (shows as gzip)
			-- So this is a hack
			vim.system({ "xournalpp", vim.fn.expand("%:p") }, { detach = true })
		else
			vim.system({ "xdg-open", vim.fn.expand("%:p") }, { detach = true })
		end
		-- Go back to previous file
		vim.cmd([[exec "normal!\<c-o>"]])
	end,
})

vim.keymap.set("n", "<leader>a", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_range_params()

	params.context = {
		triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
		diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
	}
	local lsp_clients = vim.lsp.buf_get_clients()
	local supports_code_action = false
	for k, client in pairs(lsp_clients) do
		if client.server_capabilities.codeActionProvider then
			supports_code_action = true
		end
	end

	local spellsuggest = function()
		if vim.o.spell then
			vim.fn.feedkeys("z=")
		end
	end

	if supports_code_action then
		local bufnr = vim.api.nvim_get_current_buf()
		local params = vim.lsp.util.make_range_params()

		params.context = {
			triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
			diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
		}

		vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(error, results, context, config)
			local has_action = false
			for k, action in pairs(results) do
				has_action = true
			end
			if has_action then
				vim.lsp.buf.code_action()
			else
				spellsuggest()
			end
		end)
	else
		spellsuggest()
	end
end)

-- Window mappings
vim.keymap.set("n", "<Leader>w", "<c-w>", { desc = "Window commands", remap = true })
vim.keymap.set("n", "<a-h>", "<c-w>h")
vim.keymap.set("n", "<a-j>", "<c-w>j")
vim.keymap.set("n", "<a-k>", "<c-w>k")
vim.keymap.set("n", "<a-l>", "<c-w>l")
vim.keymap.set("t", "<a-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<a-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<a-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<a-l>", "<c-\\><c-n><c-w>l")

-- Save file
vim.keymap.set("n", "<Leader>s", ":silent write<CR>", { desc = "Save buffer", silent = true })

-- Go to definition and similar
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", { desc = "List references", silent = true })
vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", { desc = "List definitions", silent = true })
vim.keymap.set("n", "gD", ":Telescope lsp_type_definitions<CR>", { desc = "List type definitions", silent = true })

vim.keymap.set("n", "<Leader>u", ":Telescope undo<CR>", { desc = "Undo history", silent = true })

-- Git
vim.keymap.set("n", "<Leader>gs", ":Neogit<CR>", { desc = "Open Neogit", silent = true })
vim.keymap.set("n", "<Leader>gc", ":Neogit commit<CR>", { desc = "Git Commit (Neogit)", silent = true })
vim.keymap.set("n", "<Leader>gP", ":Neogit push<CR>", { desc = "Git Push (Neogit)", silent = true })
vim.keymap.set("n", "<Leader>gp", ":Neogit pull<CR>", { desc = "Git Pull (Neogit)", silent = true })

-- Change colorscheme
vim.keymap.set("n", "<Leader>kt", ":Telescope colorscheme<CR>", { desc = "Select colorscheme", silent = true })

vim.keymap.set("n", "<leader>o", ":Telescope find_files<CR>", { desc = "Select file to open", silent = true })
vim.keymap.set("n", "<leader>i", ":Telescope zk notes<CR>", { desc = "Select note to open", silent = true })

-- alt-up alt-down for moving lines up or down
vim.keymap.set("n", "<a-up>", ":m .-2<CR>", { silent = true })
vim.keymap.set("n", "<a-down>", ":m .+1<CR>", { silent = true })
vim.keymap.set("i", "<a-up>", ":m .-2<CR>i", { silent = true })
vim.keymap.set("i", "<a-down>", ":m .+1<CR>i", { silent = true })
vim.keymap.set("v", "<a-up>", ":m '<-2<CR>gv", { silent = true })
vim.keymap.set("v", "<a-down>", ":m '>+1<CR>gv", { silent = true, remap = true })

-- Delete the word before the cursor (ctrl-w does this by default)
vim.keymap.set("i", "<c-BS>", "<C-W>")

-- Comment toggles
vim.keymap.set("n", "<c-/>", "gcc", { remap = true })
vim.keymap.set("v", "<c-/>", "gc gv", { remap = true })
vim.keymap.set("i", "<c-/>", "<ESC>gcc gi", { remap = true })

vim.keymap.set("n", "<CR>", "r<CR>")

-- File tree
vim.keymap.set("n", "<Leader>e", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { remap = true, desc = "Open file explorer" })

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
		enabled = false,
	},
})
