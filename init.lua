vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true

require("plugins")
require("pluginconfig")

vim.cmd("colorscheme onedark")
