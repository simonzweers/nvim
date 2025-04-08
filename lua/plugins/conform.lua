return {
	{
		"stevearc/conform.nvim",
		opts = {},
		event = 'VeryLazy',
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					cpp = { "clang_format" }
				},
				formatters = {
					clang_format = {
						prepend_args = {"--style=file:.clang-format"}
					}
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end
	}
}
