local highlight_hook = function(update_color)
	vim.api.nvim_create_autocmd("ColorScheme", { callback = update_color })
	update_color()
end

--- Close all folds whose node type matches any of the given names.
---@param node_types string[] e.g. { "function_declaration", "class_definition" }
---@param bufnr integer|nil defaults to current buffer
function _G.ts_close_nodes(node_types, filter)
	local ts = vim.treesitter
	local view = vim.fn.winsaveview()
	local parser = ts.get_parser(0)
	if not parser then
		return
	end

	local trees = parser:parse()
	if not trees or not trees[1] then
		return
	end
	local root = trees[1]:root()

	-- Convert to lookup set
	local wanted = {}
	for _, t in ipairs(node_types) do
		wanted[t] = true
	end

	-- Save/restore cursor
	local win = vim.api.nvim_get_current_win()

	local closing_lines = {}

	local function visit(node)
		if not node then
			return
		end
		if wanted[node:type()] and (filter == nil or filter(node)) then
			local start_row = node:start() + 1
			local end_row = node:end_()
			if end_row ~= start_row then
				table.insert(closing_lines, 1, start_row)
			end
		end
		for i = 0, node:child_count() - 1 do
			visit(node:child(i))
		end
	end

	visit(root)

	for _, start_row in ipairs(closing_lines) do
		vim.api.nvim_win_set_cursor(win, { start_row, 0 })
		pcall(vim.cmd, "normal! zc")
	end
	vim.fn.winrestview(view)
end

return {
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"<leader>m",
				function()
					require("treesj").toggle()
				end,
				desc = "Toggle syntax collapse/expand (treesj)",
			},
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 250,
		},
	},
	{
		"stevearc/aerial.nvim",
		keys = {
			{
				"<leader>xa",
				"<cmd>AerialToggle!<CR>",
				desc = "Outline (Aerial)",
			},
			{
				"<leader>n",
				function()
					require("aerial").snacks_picker()
				end,
				desc = "Symbol Search (Treesitter)",
			},
		},
		opts = {
			show_guides = true,
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				-- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				-- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		-- Little hint next to closing brackets showing what they correspond to
		"code-biscuits/nvim-biscuits",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("nvim-biscuits").setup({
				max_file_size = "100kb",
				cursor_line_only = true,
				default_config = {
					prefix_string = " « ",
					max_length = 50,
				},
				language_config = {
					norg = { disabled = true },
					markdown = { disabled = true },
					djot = { disabled = true },
					help = { disabled = true },
					vimdoc = { disabled = true },
					typst = { disabled = true },
				},
			})
			highlight_hook(function()
				vim.api.nvim_set_hl(0, "BiscuitColor", { link = "Comment" })
			end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install({
				"query", -- for treesitter queries
				"typescript",
				"javascript",
				"tsx",
				"jsdoc",
				"regex",
				"c",
				"cpp",
				"rust",
				"svelte",
				"html",
				"css",
				"json",
				"astro",
				"markdown",
				"lua",
				"vim",
				"vimdoc",
				"yaml",
				"bash",
				"sql",
				"djot",
				"typst",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				mode = "topline",
				min_window_height = 15,
				max_lines = 5,
				separator = "▔",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {},
					include_surrounding_whitespace = false,
				},
			})

			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "aF", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "iF", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ab", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ib", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "aa", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ia", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner", "textobjects")
			end)
		end,
	},
}
