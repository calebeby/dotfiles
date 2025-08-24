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

-- Autocompletion should be case-insensitive
vim.opt.ignorecase = true

-- Highlight the current line, but only in the active window
vim.opt.cursorline = true

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	pattern = "*",
	callback = function()
		vim.wo.cursorline = false
	end,
})

vim.api.nvim_create_autocmd({ "WinEnter" }, {
	pattern = "*",
	callback = function()
		vim.wo.cursorline = true
	end,
})

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
-- vim.wo.conceallevel = 2
vim.wo.conceallevel = 0

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

-- Allow spaces and amperstand & in filenames (for gf) (32 is ascii code for space)
vim.opt.isfname:append({ "32", "38" })
local function resolve_from(base, rel)
	rel = vim.fn.expand(rel) -- expand ~ / env
	if rel:match("^/") or rel:match("^%a:[\\/]") then
		return vim.uv.fs_realpath(rel) or vim.fn.fnamemodify(rel, ":p")
	end
	local base_dir = (base and base ~= "") and vim.fn.fnamemodify(base, ":p:h") or vim.fn.getcwd()
	local joined = base_dir .. "/" .. rel
	return vim.uv.fs_realpath(joined) or vim.fn.fnamemodify(joined, ":p")
end
vim.keymap.set("n", "gf", function()
	-- What gf normally sees (respects 'isfname')
	local file = vim.fn.expand("<cfile>")
	-- Trim whitespace
	file = file:match("^%s*(.-)%s*$")
	-- Strip leading "- " if present (YAML list items)
	file = file:gsub("^%-%s+", "")
	vim.cmd.edit(vim.fn.fnameescape(resolve_from(vim.api.nvim_buf_get_name(0), file)))
end, { noremap = true, silent = true })

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
		pdf = "image",
		png = "image",
		jpg = "image",
		jpeg = "image",
		webp = "image",
		avif = "image",
		mp4 = "video",
		mov = "video",
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

local function open_externally()
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
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "docx", "doc", "pptx", "ppt", "xls", "xlsx", "odt", "ods", "odp", "xopp" },
	group = vim.api.nvim_create_augroup("binary_files_external", { clear = true }),
	callback = open_externally,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "image", "video" },
	group = vim.api.nvim_create_augroup("image_preview", { clear = true }),
	callback = function()
		vim.bo.buftype = "nowrite"
		vim.bo.bufhidden = "delete"
		local path = vim.fn.expand("%:p")
		-- This check makes the snacks picker preview window work for images/pdfs,
		-- without trying to open them externally
		if path ~= "" then
			open_externally()
		end
	end,
})

vim.keymap.set("n", "<leader>a", function()
	local lsp_clients = vim.lsp.get_clients({ buffer = 0 })
	local supports_code_action = false
	for k, client in pairs(lsp_clients) do
		if client.server_capabilities.codeActionProvider then
			supports_code_action = true
		end
	end

	local spellsuggest = function()
		if vim.o.spell then
			require("snacks").picker.spelling()
		end
	end

	if supports_code_action then
		local params = vim.lsp.util.make_range_params(0, lsp_clients[1].offset_encoding or "utf-16")

		params.context = {
			triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
			diagnostics = vim.diagnostic.get(0),
		}

		vim.lsp.buf_request_all(0, "textDocument/codeAction", params, function(error, results, context, config)
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
vim.keymap.set("n", "<leader>w", "<c-w>", { desc = "Window commands", remap = true })
vim.keymap.set("n", "<a-h>", "<c-w>h")
vim.keymap.set("n", "<a-j>", "<c-w>j")
vim.keymap.set("n", "<a-k>", "<c-w>k")
vim.keymap.set("n", "<a-l>", "<c-w>l")
vim.keymap.set("t", "<a-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<a-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<a-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<a-l>", "<c-\\><c-n><c-w>l")

-- Save file
vim.keymap.set("n", "<leader>s", ":silent write<CR>", { desc = "Save buffer", silent = true })

-- Go to definition and similar
vim.keymap.set("n", "gr", function()
	require("snacks").picker.lsp_references()
end, { desc = "List references", silent = true })
vim.keymap.set("n", "gd", function()
	require("snacks").picker.lsp_definitions()
end, { desc = "List definitions", silent = true })
vim.keymap.set("n", "gD", function()
	require("snacks").picker.lsp_type_definitions()
end, { desc = "List type definitions", silent = true })

-- Git
vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit", silent = true })
vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = "Git Commit (Neogit)", silent = true })
vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { desc = "Git Push (Neogit)", silent = true })
vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { desc = "Git Pull (Neogit)", silent = true })
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Git Diff (Diffview)", silent = true })
vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>", { desc = "Git Log (Neogit)", silent = true })
vim.keymap.set(
	"n",
	"<leader>gL",
	":DiffviewFileHistory %<CR>",
	{ desc = "Git Log Current File (Diffview)", silent = true }
)
vim.keymap.set("n", "<leader>gz", function()
	require("snacks").lazygit.open({
		config = {
			git = {
				paging = {
					pager = string.format("delta --%s --paging=never", vim.o.background),
				},
			},
		},
	})
end, { desc = "Open LazyGit", silent = true })

vim.keymap.set(
	"n",
	"<leader>kd",
	':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>',
	{ desc = "Toggle Light/Dark", noremap = true, silent = true }
)

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

local function find_existing_dir()
	if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 then
		return vim.api.nvim_buf_get_name(0)
	end
	local dir = vim.fn.expand("%:p:h")
	while dir ~= "" and dir ~= "/" do
		print(dir)
		if vim.fn.isdirectory(dir) == 1 then
			return dir
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return nil
end

-- File tree
vim.keymap.set("n", "<leader>e", function()
	MiniFiles.open(find_existing_dir())
end, { remap = true, desc = "Open file explorer (mini.files)" })

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
		enabled = false,
	},
})
