--vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
	--callback = function(ev)
		--vim.lsp.buf.document_highlight()
	--end
--})

vim.api.nvim_create_autocmd({"CursorMoved"}, {
	callback = function(ev)
		vim.lsp.buf.clear_references()
		vim.lsp.buf.document_highlight()
	end
})
