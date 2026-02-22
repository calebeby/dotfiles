vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit", silent = true })
vim.keymap.set("n", "<leader>gd", ":CodeDiff<CR>", { desc = "Git Diff (CodeDiff)", silent = true })
vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>", { desc = "Git Log (Neogit)", silent = true })
vim.keymap.set(
	"n",
	"<leader>gL",
	":CodeDiff History %<CR>",
	{ desc = "Git Log Current File (CodeDiff)", silent = true }
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

vim.keymap.set("n", "<leader>ogl", function()
	require("snacks").picker.git_log()
end, { desc = "Open git log (snacks)" })

local function close_picker_show_commit_popup(picker)
	require("snacks").picker.get()[1]:close()
	vim.schedule(function()
		require("tinygit").smartCommit()
	end)
end

vim.keymap.set("n", "<leader>ogs", function()
	require("snacks").picker.git_status({
		focus = "list",
		win = {
			input = {
				keys = {
					["<Space>"] = "git_stage",
					["<Tab>"] = "focus_preview",
					["cc"] = close_picker_show_commit_popup,
				},
			},
			preview = {
				keys = {
					["<Space>"] = "git_stage",
					["<Tab>"] = "focus_list",
					["h"] = "focus_list",
					["cc"] = close_picker_show_commit_popup,
				},
			},
			list = {
				keys = {
					["<Space>"] = "git_stage",
					["<Tab>"] = "focus_preview",
					["l"] = "focus_preview",
					["cc"] = close_picker_show_commit_popup,
				},
			},
		},
	})
end, { desc = "Open git status (snacks)" })

vim.keymap.set("n", "<leader>ogd", function()
	require("snacks").picker.git_diff({
		focus = "list",
		tree = true,
		win = {
			input = {
				keys = {
					["<Space>"] = "git_stage",
					["<Tab>"] = "focus_preview",
					["cc"] = close_picker_show_commit_popup,
				},
			},
			preview = {
				keys = {
					["<Space>"] = "git_stage",
					["<Tab>"] = "focus_list",
					["h"] = "focus_list",
					["cc"] = close_picker_show_commit_popup,
				},
			},
			list = {
				keys = {
					["<Space>"] = "git_stage",
					["<Tab>"] = "focus_preview",
					["l"] = "focus_preview",
					["cc"] = close_picker_show_commit_popup,
				},
			},
		},
	})
end, { desc = "Open git diff (snacks)" })

return {
	{
		"SuperBo/fugit2.nvim",
		build = false,
		opts = {
			width = 100,
			libgit2_path = "libgit2.so.1.9",
			show_patch = true,
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			{
				"chrisgrieser/nvim-tinygit", -- optional: for Github PR view
				dependencies = { "stevearc/dressing.nvim" },
			},
		},
		cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
		keys = {
			{ "<leader>gs", mode = "n", "<cmd>Fugit2<cr>", desc = "Open Fugit2" },
		},
	},
	{
		"chrisgrieser/nvim-tinygit",
		keys = {
			{
				"<leader>gc",
				mode = "n",
				function()
					require("tinygit").smartCommit()
				end,
				desc = "git commit",
			},
			{
				"<leader>gp",
				mode = "n",
				function()
					require("tinygit").push()
				end,
				desc = "git push",
			},
		},
	},
	{
		"esmuellert/codediff.nvim",
		config = function()
			require("codediff").setup({
				highlights = {
					char_insert = "DiffAddInline",
					char_delete = "DiffDeleteInline",
				},
				explorer = {
					view_mode = "tree",
				},
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "codediff-explorer",
				callback = function()
					vim.keymap.set("n", "cc", function()
						require("tinygit").smartCommit()
					end, { buffer = true, desc = "Commit" })
				end,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			graph_style = "unicode",
			sections = {
				-- I prefer to show them in the recent commits view
				unmerged_upstream = {
					hidden = true,
				},
			},
			signs = {
				-- { CLOSED, OPENED }
				hunk = { "", "" },
				item = { "", "" },
				section = { "", "" },
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "" },
					change = { text = "" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "" },
				},
				signcolumn = true,
				numhl = true,
				preview_config = {
					border = "none",
					row = 1,
					col = 0,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Previous hunk" })

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hx", gitsigns.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage selection" })
					map("v", "<leader>hx", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset selection" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo hunk staging" })
					map("n", "<leader>hX", gitsigns.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hb", gitsigns.blame_line, { desc = "Show git blame for line" })
					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Vimdiff unstaged changes in file" })
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Vimdiff uncommitted changes in file" })
					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "hunk" })
				end,
			})
		end,
	},
	{
		"FabijanZulj/blame.nvim",
		cmd = "BlameToggle",
		config = function()
			require("blame").setup({
				merge_consecutive = true,
				format_fn = require("blame.formats.default_formats").date_message,
			})
		end,
	},
}
