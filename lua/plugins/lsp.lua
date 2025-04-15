return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = 'VeryLazy',
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

				vim.diagnostic.config(
					{
						virtual_text = true,
						virtual_lines = false,

					}
				)
				local virtual_lines = false

				local function toggle_diagnostics()
					if virtual_lines == true then
						-- Disable
						virtual_lines = false
						vim.diagnostic.config({
							virtual_lines = false,
							virtual_text = true,
						})
					else
						-- Enable
						virtual_lines = true
						vim.diagnostic.config({
							virtual_lines = true,
							virtual_text = false,
						})
					end
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
						-- {"<leader>gr", function() vim.lsp.buf.references() end, desc = "Go to References"},
						{"<leader><CR>", quickfix, desc = "Code action"},
						{"<F2>", function() vim.lsp.buf.rename() end, desc = "Rename"},
						{"<F3>", toggle_diagnostics, desc = "Toggle diagnostic lines"},
						{"<leader>chs", ":ClangdSwitchSourceHeader<CR>", desc = "Clangd Switch Source/Header"},
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
			lspconfig.texlab.setup({ on_attach = on_attach })
			lspconfig.lua_ls.setup({ on_attach = on_attach })
			lspconfig.gopls.setup({ on_attach = on_attach })
			lspconfig.bashls.setup({ on_attach = on_attach })
			lspconfig.ts_ls.setup({ on_attach = on_attach })
		end
	},
}
