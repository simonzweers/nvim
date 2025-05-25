return {
	{
		"mfussenegger/nvim-lint",
		-- event = "VeryLazy",
		lazy = false,
		opts = {
			linters_by_ft = {
				markdown = { "vale" },
				bash = { "shellcheck" },
				sh = { "shellcheck" },
				cpp = { "cpplint" },
			},
		},
		config = function()
			local lint = require("lint")
			vim.api.nvim_create_autocmd({ "TextChanged" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					lint.try_lint()

					-- -- You can call `try_lint` with a linter name or a list of names to always
					-- -- run specific linters, independent of the `linters_by_ft` configuration
					-- require("lint").try_lint("cspell")
				end,
			})
		end,
	},
}
