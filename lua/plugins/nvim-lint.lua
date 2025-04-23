return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "vale" },
				bash = { "bash" },
				sh = { "shfmt" },
				cpp = { "clangtidy" },
			}
		end,
	},
}
