vim.keymap.set("n", "<C-s>", vim.cmd.wa, { desc = "Save file" })

vim.keymap.set("n", "<leader>qq", vim.cmd.wqa, { desc = "Save and Quit" })
vim.keymap.set("v", "<C-c>", '"+y<CR>', { desc = "Copy into OS buffer" })

-- Insert newline under cursor
vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Insert line below cursor" })
