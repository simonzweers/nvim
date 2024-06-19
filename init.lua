local identwidth = 4

vim.g.mapleader = ' '
-- vim.keymap.set('n', '<leader>f', ':Files<CR>', {})
-- vim.keymap.set('n', '<leader>gf', ':GFiles<CR>', {})
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, {})
vim.keymap.set('n', '<C-s>', vim.cmd.wa, {})
vim.opt.autoindent = true
vim.opt.tabstop = identwidth
vim.opt.softtabstop = identwidth
vim.opt.shiftwidth = identwidth
vim.opt.number = true
vim.opt.relativenumber = true

require('plugins')
require('treesitter')
require('lsp')
require('git')
require('formatting')
require('telescope')

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
