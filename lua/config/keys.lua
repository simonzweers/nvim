vim.keymap.set("n", "<C-s>", vim.cmd.wa, { desc = "Save file" })

vim.keymap.set("n", "<leader>qq", vim.cmd.wqa, { desc = "Save and Quit" })
vim.keymap.set("v", "<C-c>", '"+y<CR>', { desc = "Copy into OS buffer" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Insert newline under/above cursor
vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Insert line below cursor" })
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert line below cursor" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert line above cursor" })
