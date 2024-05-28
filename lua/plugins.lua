local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"vim-airline/vim-airline",
	"neovim/nvim-lspconfig",
	"junegunn/fzf",
	{
		"junegunn/fzf.vim",
		keys = {
			{"<leader>ff", ":Files<CR>"},
			{"<leader>gf", ":GFiles<CR>"},
			{"<leader>fs", ":GFiles?<CR>"},
			{"<leader>rg", ":RG<CR>"}
		}
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000 ,
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }
	},

	-- LSP bs
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
})
