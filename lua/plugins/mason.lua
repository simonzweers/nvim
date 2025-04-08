return {
	{
		"williamboman/mason.nvim",
		event = 'VeryLazy',
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = 'VeryLazy',
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"clangd",
				"pylsp",
				"gopls",
				"cmake",
				"bashls",
				"zls",
				-- "clang-format",
				-- "shellcheck",
			},
		}
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"rcarriga/nvim-dap-ui",
		},
		opts = {
			handlers = {},
			ensure_installed = {
				"codelldb",
			},
		}
	},
}
