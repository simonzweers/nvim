local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-tree/nvim-tree.lua')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('navarasu/onedark.nvim')
Plug('preservim/nerdtree')

Plug('neovim/nvim-lspconfig')

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'm4xshen/autoclose.nvim'

vim.call('plug#end')

