return {
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",

		config = function()
			local lint = require("lint")

			-- Configure linters
			lint.linters_by_ft = {
				markdown = { "vale" },
				bash = { "shellcheck" },
				sh = { "shellcheck" },
				cpp = { "cpplint" },
			}

			--------------------------------------------------------------------
			-- TOGGLE: Enable/Disable linting
			--------------------------------------------------------------------
			local lint_enabled = false

			local function toggle_lint()
				lint_enabled = not lint_enabled

				if lint_enabled then
					vim.notify("nvim-lint: enabled", vim.log.levels.INFO)
					lint.try_lint()
				else
					vim.notify("nvim-lint: disabled", vim.log.levels.WARN)
					-- Clear diagnostics from all linters
					vim.diagnostic.reset(nil, 0)
				end
			end

			vim.keymap.set("n", "<leader>lt", toggle_lint, {
				desc = "Toggle lint diagnostics",
			})

			--------------------------------------------------------------------
			-- AUTOCMD: Run linting on save / leave insert / etc.
			--------------------------------------------------------------------
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
				callback = function()
					if lint_enabled then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
