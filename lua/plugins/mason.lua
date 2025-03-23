return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
			}
		},
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"clangd",
				"pylsp",
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
