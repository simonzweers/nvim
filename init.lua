local identwidth = 4

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.keymap.set('n', '<leader>f', ':Files<CR>', {})
-- vim.keymap.set('n', '<leader>gf', ':GFiles<CR>', {})
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex, {})
-- vim.keymap.set('n', '<C-s>', vim.cmd.wa, {})
-- vim.keymap.set('n', '<leader>qq', vim.cmd.wqa, {})
-- vim.keymap.set('v', '<C-c>', '"+y<CR>', {})

vim.opt.autoindent = true
vim.opt.tabstop = identwidth
vim.opt.softtabstop = identwidth
vim.opt.shiftwidth = identwidth
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.conceallevel = 2
vim.opt.termguicolors = true
vim.opt.scrolloff = 7
vim.opt.laststatus = 3
-- vim.opt.clipboard = "unnamedplus"

require("config.plugins")

require("config.theme")
require("config.autocmds")
-- require('config.lsp') -- Uncomment for using built-in lsp config

local wk = require("which-key")
wk.add({
	{ "<C-s>", vim.cmd.wa, desc = "Save file", mode = "n" },
	{ "<leader>qq", vim.cmd.wqa, desc = "Save and Quit", mode = "n" },
	{ "<C-c>", '"+y<CR>', desc = "Copy into OS buffer", mode = "v" },
})
