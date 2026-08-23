vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = args.match
    local lang = vim.treesitter.language.get_lang(ft) or ft

    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.bo[args.buf].syntax = "off" -- avoid legacy regex syntax fighting with Treesitter
    end
  end,
})
