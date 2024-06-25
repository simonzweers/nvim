return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "lukas-reineke/lsp-format.nvim" },
		config = function() 
			local lspconfig = require('lspconfig')
			require("lsp-format").setup {}
			local on_attach = function(client, bufnr)
				require("lsp-format").on_attach(client, bufnr)
				print('lsp on_attach')
				local opts = {buffer = bufnr, remap = false}

				vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set({"i", "n"}, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
			end
			lspconfig.clangd.setup({ on_attach = on_attach })
			lspconfig.cmake.setup({ on_attach = on_attach })
			lspconfig.rust_analyzer.setup({ on_attach = on_attach })
			lspconfig.pylsp.setup({ on_attach = on_attach })
		end
	},
	{
		'williamboman/mason.nvim',
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {

				},
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				},
			})

		end
	},
	{'hrsh7th/cmp-nvim-lsp'},
	{
		'hrsh7th/nvim-cmp',
		config = function() 
			local cmp = require('cmp')
			local cmp_select = {behavior = cmp.SelectBehavior.Select}
			require('luasnip.loaders.from_vscode').lazy_load()
			cmp.setup({
				sources = {
					{name = 'path'},
					{name = 'nvim_lsp'},
					{name = 'nvim_lua'},
					{name = 'luasnip', keyword_length = 2},
					{name = 'buffer', keyword_length = 3},
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<CR>'] = cmp.mapping.confirm(),
				}),
			})
		end
	},
	{'L3MON4D3/LuaSnip'},
}