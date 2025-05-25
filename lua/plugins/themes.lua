return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 1000,
		config = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
	},
	{
		"navarasu/onedark.nvim",
		lazy = true,
		config = function()
			require("onedark").setup({
				style = "darker",
			})
			require("onedark").load()
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = true,
	},
}
