return {

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000 ,
		config = true,
	},
	"rebelot/kanagawa.nvim",
	{
		"catppuccin/nvim",
		name = "catppuccin", 
		priority = 1000 
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		'navarasu/onedark.nvim',
		config = function() 
			require('onedark').setup {
				style = 'darker'
			}
			require('onedark').load()
		end
	},
	'Mofiqul/vscode.nvim',
}
