local identwidth = 4

vim.g.mapleader = ' '
-- vim.keymap.set('n', '<leader>f', ':Files<CR>', {})
-- vim.keymap.set('n', '<leader>gf', ':GFiles<CR>', {})
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex, {})
vim.keymap.set('n', '<C-s>', vim.cmd.wa, {})
vim.keymap.set('n', '<leader>qq', vim.cmd.wqa, {})
vim.opt.autoindent = true
vim.opt.tabstop = identwidth
vim.opt.softtabstop = identwidth
vim.opt.shiftwidth = identwidth
vim.opt.number = true
vim.opt.relativenumber = true

require('config.plugins')
-- require('lsp')
require('formatting')
require('telescope')
require('tabline')

vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
vim.cmd("colorscheme kanagawa-dragon")
-- vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme kanagawa-lotus")
-- vim.cmd.colorscheme "catppuccin"
