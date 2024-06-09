return {
	{
		"rebelot/heirline.nvim",
		config = function()
			local conditions = require("heirline.conditions")
			local utils = require("heirline.utils")

			local util = {}

			util.icons = {
				powerline = {
					-- 
					vertical_bar_thin = "│",
					vertical_bar = "┃",
					block = "█",
					----------------------------------------------
					left = "",
					left_filled = "",
					right = "",
					right_filled = "",
					----------------------------------------------
					slant_left = "",
					slant_left_thin = "",
					slant_right = "",
					slant_right_thin = "",
					----------------------------------------------
					slant_left_2 = "",
					slant_left_2_thin = "",
					slant_right_2 = "",
					slant_right_2_thin = "",
					----------------------------------------------
					left_rounded = "",
					left_rounded_thin = "",
					right_rounded = "",
					right_rounded_thin = "",
					----------------------------------------------
					trapezoid_left = "",
					trapezoid_right = "",
				},
				padlock = "",
				circle_small = "●", -- ●
				circle = "", -- 
				circle_plus = "", -- 
				dot_circle_o = "", -- 
				circle_o = "⭘", -- ⭘
			}

			util.mode = setmetatable({
				n = "normal",
				no = "op",
				nov = "op",
				noV = "op",
				["no"] = "op",
				niI = "normal",
				niR = "normal",
				niV = "normal",
				nt = "normal",
				v = "visual",
				V = "visual_lines",
				[""] = "visual_block",
				s = "select",
				S = "select",
				[""] = "block",
				i = "insert",
				ic = "insert",
				ix = "insert",
				R = "replace",
				Rc = "replace",
				Rv = "v_replace",
				Rx = "replace",
				c = "command",
				cv = "command",
				ce = "command",
				r = "enter",
				rm = "more",
				["r?"] = "confirm",
				["!"] = "shell",
				t = "terminal",
				["null"] = "none",
			}, {
				__call = function(self, raw_mode)
					return self[raw_mode]
				end,
			})

			util.mode_lable = {
				normal = "NormaL",
				op = "OP",
				visual = "Visual",
				visual_lines = "V-Line",
				visual_block = "V-Block",
				select = "Select",
				block = "Block",
				insert = "Insert",
				replace = "Replace",
				v_replace = "V-Replace",
				command = "Command",
				enter = "Enter",
				more = "More",
				confirm = "Confirm",
				shell = "Shell",
				terminal = "Terminal",
				none = "None",
			}

			---set minimal width of a component using item group
			---@param width integer
			---@param component table
			---@return table
			local function min_width(width, component)
				-- %-{width}({component}%)
				return {
					{ provider = "%-" .. tostring(width) .. "(" },
					component,
					{ provider = "%)" },
				}
			end

			local TabList = utils.make_tablist({
				init = function(self)
					local windows = vim.api.nvim_tabpage_list_wins(self.tabpage)
					local buffers = {}
					for i, win in pairs(windows) do
						buffers[i] = vim.api.nvim_win_get_buf(win)
					end
					self.buffers = buffers
				end,

				hl = function(self)
					if self.is_active then
						return { fg = "normal_fg", bg = "normal_bg" }
					else
						return { fg = "tabline_fg", bg = "tabline_bg" }
					end
				end,

				-- Start tab label
				-- See :h 'statusline' and search for 'tabline'
				{
					provider = function(self)
						return "%" .. tostring(self.tabnr) .. "T"
					end,
				},
				{
					provider = "",
					hl = function(self)
						if self.is_active then
							return { bg = "tabline_fill", fg = "normal_bg" }
						else
							return { bg = "tabline_fill", fg = "tabline_bg" }
						end
					end,
				},
				{
					provider = function(self)
						return (" %d: "):format(self.tabnr)
					end,
				},
				min_width(10, {
					provider = function(self)
						local MAX_COUNT = 4 -- max number of icons that can fit in the label
						local ft_count = {} -- number of buffers with each filetype
						local total_count = 0 -- total number of filtered buffers
						local truncate = false -- total_count > MAX_COUNT
						for _, bufnr in pairs(self.buffers) do
							if total_count == MAX_COUNT then
								truncate = true
								break
							end

							local bo = vim.bo[bufnr]

							-- filter out special buffers
							-- nameless buffers are displayed only if modified
							if (bo.buftype == "" or bo.buftype == "nowrite") and (bo.filetype ~= "" or bo.modified) then
								ft_count[bo.filetype] = (ft_count[bo.filetype] or 0) + 1
								total_count = total_count + 1
							end
						end

						local devicons = require("nvim-web-devicons")
						local children = {}
						for filetype, count in pairs(ft_count) do
							local icon, hl = devicons.get_icon_by_filetype(filetype, { default = true })

							children[#children + 1] = {
								provider = ("%s "):format(icon):rep(count),
								hl = hl,
							}
						end

						if truncate == true then
							children[#children + 1] = {
								provider = "… ",
								-- hl = { fg = "InactiveFG" },
							}
						end

						return self:new(children):eval()
					end,
				}),
				{
					provider = function(self)
						-- Close button - The extra format characters tell nvim which tab to close
						-- See :h 'statusline' and search for 'tabline'
						return "%" .. tostring(self.tabnr) .. "X ✕ %X"
					end,
				},
				{
					provider = "",
					hl = function(self)
						if self.is_active then
							return { bg = "tabline_fill", fg = "normal_bg" }
						else
							return { bg = "tabline_fill", fg = "tabline_bg" }
						end
					end,
				},
				-- End tab label
				-- See :h 'statusline' and search for 'tabline'
				{ provider = "%T" },
			})

			local TabLine = {
				TabList,
			}

			if not pcall(require, "heirline") then
				return
			end

			local os_sep = package.config:sub(1, 1)
			local api = vim.api
			local fn = vim.fn
			local bo = vim.bo

			local function setup_colors()
				local tabline_fill = utils.get_highlight("TabLineFill").bg
				local tabline_bg = utils.get_highlight("TabLine").bg
				local tabline_fg = utils.get_highlight("TabLine").fg
				local statusline_bg = utils.get_highlight("StatusLine").bg
				local statusline_fg = utils.get_highlight("StatusLine").fg
				local normal_bg = utils.get_highlight("Normal").bg
				local normal_fg = utils.get_highlight("Normal").fg
				local bright_bg = utils.get_highlight("Folded").bg
				local bright_fg = utils.get_highlight("Folded").fg
				local red = utils.get_highlight("DiagnosticError").fg
				local dark_red = utils.get_highlight("DiffDelete").bg
				local green = utils.get_highlight("String").fg
				local blue = utils.get_highlight("Function").fg
				local gray = utils.get_highlight("NonText").fg
				local orange = utils.get_highlight("Constant").fg
				local purple = utils.get_highlight("Statement").fg
				local cyan = utils.get_highlight("Special").fg

				return {
					tabline_fill = tabline_fill,
					tabline_bg = tabline_bg,
					tabline_fg = tabline_fg,
					statusline_fg = statusline_fg,
					statusline_bg = statusline_bg,
					normal_fg = normal_fg,
					normal_bg = normal_bg,
					bright_fg = bright_fg,
					bright_bg = bright_bg,
					modified = orange,

					mode_normal = blue,
					mode_op = blue,
					mode_normal = blue,
					mode_visual = green,
					mode_visual_lines = green,
					mode_visual_block = green,
					mode_select = blue,
					mode_block = blue,
					mode_insert = cyan,
					mode_replace = blue,
					mode_v_replace = blue,
					mode_replace = red,
					mode_command = blue,
					mode_enter = blue,
					mode_more = blue,
					mode_confirm = blue,
					mode_shell = blue,
					mode_terminal = blue,
					mode_none = blue,

					diag_warn = utils.get_highlight("DiagnosticWarn").fg,
					diag_error = utils.get_highlight("DiagnosticError").fg,
					diag_hint = utils.get_highlight("DiagnosticHint").fg,
					diag_info = utils.get_highlight("DiagnosticInfo").fg,
					git_del = utils.get_highlight("diffDeleted").fg,
					git_add = utils.get_highlight("diffAdded").fg,
					git_change = utils.get_highlight("diffChanged").fg,
				}
			end

			local conditions = require("heirline.conditions")
			local heirline = require("heirline.utils")
			local devicons = require("nvim-web-devicons")
			local icons = util.icons
			local mode = util.mode
			local colors = setup_colors()

			local priority = {
				CurrentPath = 60,
				Git = 40,
				WorkDir = 25,
				Lsp = 10,
			}

			local Align, Space, Null, ReadOnly
			do
				Null = { provider = "" }

				Align = { provider = "%=" }

				Space = setmetatable({ provider = " " }, {
					__call = function(_, n)
						return { provider = string.rep(" ", n) }
					end,
				})

				ReadOnly = {
					condition = function()
						return not bo.modifiable or bo.readonly
					end,
					provider = icons.padlock,
					-- hl = hl.ReadOnly,
				}
			end

			local LeftCap = {
				provider = "▌",
				-- provider = '',
				-- hl = hl.Mode.normal,
			}

			local Indicator
			do
				local VimMode
				do
					local NormalModeIndicator = {
						Space,
						{
							fallthrough = false,
							ReadOnly,
							{
								provider = icons.circle,
								hl = function()
									if bo.modified then
										return { fg = "modified" }
									else
										return { fg = "mode_normal" }
									end
								end,
							},
						},
						Space,
					}

					local ActiveModeIndicator = {
						condition = function(self)
							return self.mode ~= "normal"
						end,
						-- hl = { bg = hl.StatusLine.bg },
						heirline.surround(
							{ icons.powerline.left_rounded, icons.powerline.right_rounded },
							function(self) -- color
								return colors["mode_" .. self.mode]
							end,
							{
								{
									fallthrough = false,
									ReadOnly,
									{ provider = icons.circle },
								},
								Space,
								{
									provider = function(self)
										return util.mode_lable[self.mode]
									end,
								},
								hl = function(self)
									return { bg = "mode_" .. self.mode, fg = colors.normal_bg, bold = true }
								end,
							}
						),
					}

					VimMode = {
						init = function(self)
							self.mode = mode[fn.mode(1)] -- :h mode()
						end,
						condition = function()
							return bo.buftype == ""
						end,
						{
							fallthrough = false,
							ActiveModeIndicator,
							NormalModeIndicator,
						},
					}
				end

				Indicator = {
					fallthrough = false,
					VimMode,
				}
			end

			local FileNameBlock, CurrentPath, FileName
			do
				local FileIcon = {
					condition = function()
						return not ReadOnly.condition()
					end,
					init = function(self)
						local filename = self.filename
						local extension = fn.fnamemodify(filename, ":e")
						self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
					end,
					provider = function(self)
						if self.icon then
							return self.icon .. " "
						end
					end,
					hl = function(self)
						return { fg = self.icon_color }
					end,
				}

				local WorkDir = {
					condition = function(self)
						if bo.buftype == "" then
							return self.pwd
						end
					end,
					-- hl = hl.WorkDir,
					flexible = priority.WorkDir,
					{
						provider = function(self)
							return self.pwd
						end,
					},
					{
						provider = function(self)
							return fn.pathshorten(self.pwd)
						end,
					},
					Null,
				}

				CurrentPath = {
					condition = function(self)
						if bo.buftype == "" then
							return self.current_path
						end
					end,
					-- hl = hl.CurrentPath,
					flexible = priority.CurrentPath,
					{
						provider = function(self)
							return self.current_path
						end,
					},
					{
						provider = function(self)
							return fn.pathshorten(self.current_path, 2)
						end,
					},
					{ provider = "" },
				}

				FileName = {
					provider = function(self)
						return self.filename
					end,
					-- hl = hl.FileName,
				}

				FileNameBlock = {
					{ FileIcon, WorkDir, CurrentPath, FileName },
					-- This means that the statusline is cut here when there's not enough space.
					{ provider = "%<" },
				}
			end

			--------------------------------------------------------------------------------

			local FileProperties = {
				condition = function(self)
					self.filetype = bo.filetype

					local encoding = (bo.fileencoding ~= "" and bo.fileencoding) or vim.o.encoding
					self.encoding = (encoding ~= "utf-8") and encoding or nil

					local fileformat = bo.fileformat

					-- if fileformat == 'dos' then
					--    fileformat = ' '
					-- elseif fileformat == 'mac' then
					--    fileformat = ' '
					-- else  -- unix'
					--    fileformat = ' '
					--    -- fileformat = nil
					-- end

					if fileformat == "dos" then
						fileformat = "CRLF"
					elseif fileformat == "mac" then
						fileformat = "CR"
					else -- 'unix'
						-- fileformat = 'LF'
						fileformat = nil
					end

					self.fileformat = fileformat

					return self.fileformat or self.encoding
				end,
				provider = function(self)
					local sep = (self.fileformat and self.encoding) and " " or ""
					return table.concat({ " ", self.fileformat or "", sep, self.encoding or "", " " })
				end,
				-- hl = hl.FileProperties,
			}

			local Diagnostics = {
				condition = conditions.has_diagnostics,
				static = {
					error_icon = " ",
					warn_icon = " ",
					info_icon = " ",
					hint_icon = "",
				},
				on_click = {
					callback = function()
						vim.cmd("Trouble diagnostics toggle")
					end,
					name = "heirline_diagnostics",
				},
				init = function(self)
					self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
					self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				end,
				{
					provider = function(self)
						-- 0 is just another output, we can decide to print it or not!
						if self.errors > 0 then
							return table.concat({ self.error_icon, self.errors, " " })
						end
					end,
					hl = { fg = "diag_error" },
				},
				{
					provider = function(self)
						if self.warnings > 0 then
							return table.concat({ self.warn_icon, self.warnings, " " })
						end
					end,
					-- hl = hl.Diagnostic.warn,
				},
				{
					provider = function(self)
						if self.info > 0 then
							return table.concat({ self.info_icon, self.info, " " })
						end
					end,
					-- hl = hl.Diagnostic.info,
				},
				{
					provider = function(self)
						if self.hints > 0 then
							return table.concat({ self.hint_icon, self.hints, " " })
						end
					end,
					-- hl = hl.Diagnostic.hint,
				},
				Space(2),
			}

			local Git
			do
				local GitBranch = {
					condition = conditions.is_git_repo,
					init = function(self)
						self.git_status = vim.b.gitsigns_status_dict
					end,
					-- hl = hl.Git.branch,
					provider = function(self)
						return table.concat({ " ", self.git_status.head })
					end,
					on_click = {
						callback = function()
							vim.cmd("Telescope git_branches")
						end,
						name = "heirline_git",
					},
				}

				Git = { GitBranch, Space }
			end

			local Lsp
			do
				local LspIndicator = {
					provider = icons.circle_small .. " ",
					-- hl = hl.LspIndicator,
				}

				local LspServer = {
					Space,
					{
						provider = function(self)
							local names = self.lsp_names
							if #names == 1 then
								names = names[1]
							else
								-- names = table.concat(vim.tbl_flatten({ '[', names, ']' }), ' ')
								names = table.concat(names, ", ")
							end
							return names
						end,
						on_click = {
							callback = function()
								vim.cmd("LspInfo")
							end,
							name = "heirline_LSP",
						},
					},
					Space(2),
					-- hl = hl.LspServer,
				}

				Lsp = {
					condition = conditions.lsp_attached,
					init = function(self)
						local names = {}
						for _, server in pairs(vim.lsp.buf_get_clients(0)) do
							table.insert(names, server.name)
						end
						self.lsp_names = names
					end,
					-- hl = hl.LspServer,
					flexible = priority.Lsp,
					LspServer,
					LspIndicator,
				}
			end

			local SearchResults = {
				condition = function(self)
					local lines = api.nvim_buf_line_count(0)
					if lines > 50000 then
						return
					end

					local query = fn.getreg("/")
					if query == "" then
						return
					end

					if query:find("@") then
						return
					end

					local search_count = fn.searchcount({ recompute = 1, maxcount = -1 })
					local active = false
					if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
						active = true
					end
					if not active then
						return
					end

					query = query:gsub([[^\V]], "")
					query = query:gsub([[\<]], ""):gsub([[\>]], "")

					self.query = query
					self.count = search_count
					return true
				end,
				{
					provider = function(self)
						return table.concat({
							-- ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
							" ",
							self.count.current,
							"/",
							self.count.total,
							" ",
						})
					end,
					-- hl = hl.SearchResults,
				},
				Space,
			}

			local Ruler = {
				-- :help 'statusline'
				provider = " %l:%c ",
				hl = { bold = true },
			}

			local ScrollPercentage = {
				condition = function()
					return conditions.width_percent_below(4, 0.035)
				end,
				-- %P  : percentage through file of displayed window
				provider = " %3(%P%) ",
				-- hl = hl.StatusLine,
			}

			--------------------------------------------------------------------------------

			local HelpBufferStatusline = {
				condition = function()
					return bo.filetype == "help"
				end,
				Space,
				Indicator,
				{
					provider = function()
						local filename = api.nvim_buf_get_name(0)
						return fn.fnamemodify(filename, ":t")
					end,
					-- hl = hl.FileName,
				},
				Align,
				ScrollPercentage,
			}

			local StatusLines = {
				init = function(self)
					local pwd = fn.getcwd(0) -- Present working directory.
					local current_path = api.nvim_buf_get_name(0)
					local filename

					if current_path == "" then
						pwd = fn.fnamemodify(pwd, ":~")
						current_path = nil
						filename = " [No Name]"
					elseif current_path:find(pwd, 1, true) then
						filename = fn.fnamemodify(current_path, ":t")
						current_path = fn.fnamemodify(current_path, ":~:.:h")
						pwd = fn.fnamemodify(pwd, ":~") .. os_sep
						if current_path == "." then
							current_path = nil
						else
							current_path = current_path .. os_sep
						end
					else
						pwd = nil
						filename = fn.fnamemodify(current_path, ":t")
						current_path = fn.fnamemodify(current_path, ":~:.:h") .. os_sep
					end

					self.pwd = pwd
					self.current_path = current_path -- The opened file path relevant to pwd.
					self.filename = filename
				end,
				hl = { fg = "statusline_fg", bg = "statusline_bg" },
				{
					LeftCap,
					Indicator,
					Space,
					{
						fallthrough = false,
						{ SearchResults, FileNameBlock },
					},
					Space(4),
					Align,
					Diagnostics,
					Git,
					Lsp,
					FileProperties,
					Ruler,
					ScrollPercentage,
				},
			}

			--------------------------------------------------------------------------------

			require("heirline").setup({
				statusline = StatusLines,
				-- winbar = WinBars,
				tabline = TabLine,
				-- statuscolumn = ...
			})

			require("heirline").setup({})
			require("heirline").load_colors(setup_colors)

			vim.api.nvim_create_augroup("Heirline", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					colors = setup_colors()
					utils.on_colorscheme(setup_colors)
				end,
				group = "Heirline",
			})
		end,
	},
}
