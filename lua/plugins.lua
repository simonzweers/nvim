vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- use 'vim-tree/nvim-web-devicons'
	use 'nvim-tree/nvim-tree.lua'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'navarasu/onedark.nvim'
	use 'preservim/nerdtree'

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	-- use 'm4xshen/autoclose.nvim'

end)
