return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"haskell",
				"go",
				"java",
				"python",
			})
		end,
	},
}
