--vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
--callback = function(ev)
--vim.lsp.buf.document_highlight()
--end
--})

print("Autocmds")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "systemverilog",
	callback = function()
		print("Detected sv filetype")
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4 -- Set the number of spaces a tab counts for
		vim.opt_local.shiftwidth = 4 -- Set the number of spaces for each indentation level
	end,
})
