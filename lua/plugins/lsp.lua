return {
	{
		"neovim/nvim-lspconfig",
		--dependencies = { "lukas-reineke/lsp-format.nvim" },
		config = function() 
			local lspconfig = require('lspconfig')
			-- require("lsp-format").setup {}
			local on_attach = function(client, bufnr)
				-- require("lsp-format").on_attach(client, bufnr)
				local opts = {buffer = bufnr, remap = false}
				
				local qfopts = { noremap=true, silent=true }
				local function quickfix()
					vim.lsp.buf.code_action()
				end

				
				local wk = require("which-key")
				wk.add({
					{
						mode = 'n',

						{"<leader>gd", function() vim.lsp.buf.definition() end, desc = "Go to Definition"},
						{"<leader>gD", function() vim.lsp.buf.declaration() end, desc = "Go to Declaration"},
						{"<leader>gb", "<C-^>", desc = "Go to previous buffer"},
						{"<leader>gi", function() vim.lsp.buf.implementation() end, desc = "Go to Implementation"},
						{"<leader>gt", function() vim.lsp.buf.type_definition() end, desc = "Go to Type Definition"},
						{"<leader>gr", function() vim.lsp.buf.references() end, desc = "Go to References"},
						{"<leader><CR>", quickfix, desc = "Code action"},
						{"<F2>", function() vim.lsp.buf.rename() end, desc = "Rename"},
					},

					{"<C-h>", function() vim.lsp.buf.signature_help() end, mode = {'n', 'i'}, desc = "Signature Help"}
					
				})

				if vim.lsp.inlay_hint then
					wk.add({
						{
							"<leader>L",
							function() 
								if vim.lsp.inlay_hint.is_enabled() 
									then vim.lsp.inlay_hint.enable(false, { bufnr })
									else vim.lsp.inlay_hint.enable(true, { bufnr })
									end 
								end,

							desc = "Toggle inlay hints"
						}
					})
				end
				if client.supports_method('textDocument/documentHighlight') then
					vim.api.nvim_create_autocmd({"CursorMoved"}, {
						buffer = bufnr,
						callback = function(ev)
							vim.lsp.buf.clear_references()
							vim.lsp.buf.document_highlight()
						end
					})
				end

			end
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
			lspconfig.clangd.setup({
				on_attach = on_attach,
				cmd = { "clangd", "--completion-style=detailed" } }
			)
			lspconfig.cmake.setup({ on_attach = on_attach })
			lspconfig.rust_analyzer.setup({ on_attach = on_attach })
			lspconfig.pylsp.setup({ on_attach = on_attach })
			lspconfig.zls.setup({ on_attach = on_attach })
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
	{
		'hrsh7th/nvim-cmp',
		config = function() 
			local cmp = require('cmp')
			local cmp_select = {behavior = cmp.SelectBehavior.Select}
			require('luasnip.loaders.from_vscode').lazy_load()
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{name = 'luasnip', priority = 100},
					{name = 'nvim_lsp', priority = 50},
					{name = 'nvim_lsp_signature_help' },
					{name = 'path'},
					{name = 'nvim_lua'},
					{name = 'buffer', keyword_length = 3},
				}),
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<CR>'] = cmp.mapping.confirm({select = true}),
					['<Tab>'] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }), -- Tab to expand or jump
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }), -- Shift-Tab to jump backward
				}),
			})
		end
	},
	{
		'L3MON4D3/LuaSnip',
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{'hrsh7th/cmp-nvim-lsp'},
}
