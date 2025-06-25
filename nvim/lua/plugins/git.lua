return {
	{
		"SuperBo/fugit2.nvim",
		build = false,
		opts = {
			width = 100,
			libgit2_path = "libgit2.so.1.9",
			show_patch = true,
			external_diffview = true, -- tell fugit2 to use diffview.nvim instead of builtin implementation.
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
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			graph_style = "unicode",
			integrations = {
				telescope = false, -- Use vim.ui.select, which is set to telescope by dressing.nvim
			},
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
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewOpen", "DiffviewFileHistory" },
		opts = {
			enhanced_diff_hl = true,
			keymaps = {
				view = {
					{ { "n" }, "q", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
					{ { "n" }, "c", "<Cmd>Neogit commit<CR>", { desc = "Commit" } },
				},
				file_panel = {
					{ { "n" }, "q", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
					{ { "n" }, "c", "<Cmd>Neogit commit<CR>", { desc = "Commit" } },
					{
						{ "n" },
						"<tab>",
						function()
							require("diffview.actions").toggle_fold()
						end,
						{ desc = "Toggle Fold" },
					},
					{
						{ "n" },
						"u",
						function()
							require("diffview.actions").toggle_stage_entry()
						end,
						{ desc = "Toggle Staged" },
					},
					{
						{ "n" },
						"<c-s>",
						function()
							require("diffview.actions").stage_all()
						end,
						{ desc = "Stage All" },
					},
				},
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
