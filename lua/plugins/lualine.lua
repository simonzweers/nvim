return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Eviline config for lualine
			-- Author: shadmansaleh
			-- Credit: glepnir
			local lualine = require("lualine")

			-- Returns the fg/bg of a highlight group as "#rrggbb" (resolving links and
			-- `reverse`), or nil if the group doesn't define it
			local function hl_color(group, attr)
				local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
				if not ok or not hl then
					return nil
				end
				local fg, bg = hl.fg, hl.bg
				if hl.reverse then
					fg, bg = bg, fg
				end
				local value = attr == "fg" and fg or bg
				return value and string.format("#%06x", value) or nil
			end

			-- Returns the first color found in the given highlight groups
			local function pick(attr, ...)
				for _, group in ipairs({ ... }) do
					local color = hl_color(group, attr)
					if color then
						return color
					end
				end
				return "NONE"
			end

			-- Color table derived from the active colorscheme
			local function get_colors()
				-- stylua: ignore
				return {
					fg       = pick("fg", "StatusLine", "Normal"),
					bg       = pick("bg", "StatusLine", "Normal"),
					editor_bg = pick("bg", "Normal", "NormalFloat", "StatusLine"),
					muted    = pick("fg", "Comment", "NonText"),
					title    = pick("fg", "Title", "Function"),
					branch   = pick("fg", "Statement", "Keyword"),
					error    = pick("fg", "DiagnosticError", "ErrorMsg"),
					warn     = pick("fg", "DiagnosticWarn", "WarningMsg"),
					info     = pick("fg", "DiagnosticInfo", "Special"),
					hint     = pick("fg", "DiagnosticHint", "Special"),
					added    = pick("fg", "GitSignsAdd", "Added", "diffAdded", "DiagnosticOk", "String"),
					changed  = pick("fg", "GitSignsChange", "Changed", "diffChanged", "DiagnosticWarn"),
					removed  = pick("fg", "GitSignsDelete", "Removed", "diffRemoved", "DiagnosticError"),
					-- Mode accents
					normal   = pick("fg", "Function", "Directory"),
					insert   = pick("fg", "String", "DiagnosticOk"),
					visual   = pick("fg", "Statement", "Keyword"),
					replace  = pick("fg", "DiagnosticError", "ErrorMsg"),
					command  = pick("fg", "DiagnosticWarn", "WarningMsg"),
					select   = pick("fg", "Constant", "Number"),
					terminal = pick("fg", "DiagnosticInfo", "Special"),
				}
			end

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			local function build_config()
				local colors = get_colors()

				-- Accent color for the current mode
				local function mode_color()
					-- stylua: ignore
					local mode_colors = {
						n      = colors.normal,
						i      = colors.insert,
						v      = colors.visual,
						V      = colors.visual,
						["\22"] = colors.visual, -- CTRL-V
						c      = colors.command,
						s      = colors.select,
						S      = colors.select,
						["\19"] = colors.select, -- CTRL-S
						R      = colors.replace,
						r      = colors.replace,
						["!"]  = colors.terminal,
						t      = colors.terminal,
					}
					return mode_colors[vim.fn.mode():sub(1, 1)] or colors.normal
				end

				-- Line-number block: inverted mode accent so it stands out from the editor
				local function location_color()
					return { fg = colors.editor_bg, bg = mode_color(), gui = "bold" }
				end

				-- Config
				local config = {
					options = {
						-- Disable sections and component separators
						component_separators = "",
						section_separators = "",
						theme = {
							-- We are going to use lualine_c an lualine_x as left and
							-- right section. Both are highlighted by c theme .  So we
							-- are just setting default looks o statusline
							normal = { c = { fg = colors.fg, bg = colors.bg } },
							inactive = { c = { fg = colors.muted, bg = colors.bg } },
						},
					},
					sections = {
						-- these are to remove the defaults
						lualine_a = {},
						lualine_b = {},
						lualine_y = {},
						lualine_z = {},
						-- These will be filled later
						lualine_c = {},
						lualine_x = {},
					},
					inactive_sections = {
						-- these are to remove the defaults
						lualine_a = {},
						lualine_b = {},
						lualine_y = {},
						lualine_z = {},
						lualine_c = {},
						lualine_x = {},
					},
				}

				-- Inserts a component in lualine_c at left section
				local function ins_left(component)
					table.insert(config.sections.lualine_c, component)
				end

				-- Inserts a component in lualine_x at right section
				local function ins_right(component)
					table.insert(config.sections.lualine_x, component)
				end

				ins_left({
					function()
						return "▊"
					end,
					color = function()
						return { fg = mode_color() }
					end,
					padding = { left = 0, right = 1 }, -- We don't need space before this
				})

				ins_left({
					-- mode component
					function()
						-- return "      "
						return " "
					end,
					color = function()
						-- auto change color according to neovims mode
						return { fg = mode_color() }
					end,
					padding = { right = 1 },
				})

				ins_left({
					-- filesize component
					"filesize",
					cond = conditions.buffer_not_empty,
					color = { fg = colors.muted },
				})

				ins_left({
					"filename",
					cond = conditions.buffer_not_empty,
					color = { fg = colors.title, gui = "bold" },
				})

				ins_left({ "location", color = location_color, padding = { left = 1, right = 0 } })

				ins_left({ "progress", color = location_color, padding = { left = 1, right = 1 } })

				ins_left({
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					diagnostics_color = {
						error = { fg = colors.error },
						warn = { fg = colors.warn },
						info = { fg = colors.info },
						hint = { fg = colors.hint },
					},
				})

				-- Insert mid section. You can make any number of sections in neovim :)
				-- for lualine it's any number greater then 2
				ins_left({
					function()
						return "%="
					end,
				})

				ins_left({
					-- Lsp server name .
					function()
						local msg = "No Active Lsp"
						local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
						local clients = vim.lsp.get_clients()
						if next(clients) == nil then
							return msg
						end
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return client.name
							end
						end
						return msg
					end,
					icon = " LSP:",
					color = { fg = colors.fg, gui = "bold" },
				})

				-- Add components to right sections
				ins_right({
					"o:encoding", -- option component same as &encoding in viml
					fmt = string.upper, -- I'm not sure why it's upper case either ;)
					cond = conditions.hide_in_width,
					color = { fg = colors.muted },
				})

				ins_right({
					"fileformat",
					fmt = string.upper,
					icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
					color = { fg = colors.muted },
				})

				ins_right({
					"branch",
					icon = " ",
					color = { fg = colors.branch, gui = "bold" },
				})

				ins_right({
					"diff",
					-- Is it me or the symbol for modified us really weird
					symbols = { added = " ", modified = "󰝤 ", removed = " " },
					diff_color = {
						added = { fg = colors.added },
						modified = { fg = colors.changed },
						removed = { fg = colors.removed },
					},
					cond = conditions.hide_in_width,
				})

				ins_right({
					function()
						return "▊"
					end,
					color = function()
						return { fg = mode_color() }
					end,
					padding = { left = 1 },
				})

				return config
			end

			lualine.setup(build_config())

			-- Re-derive all colors whenever the colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("LualineThemeColors", { clear = true }),
				callback = function()
					lualine.setup(build_config())
				end,
			})
		end,
	},
}
