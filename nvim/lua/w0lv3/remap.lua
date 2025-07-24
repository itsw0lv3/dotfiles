vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_set_keymap("n", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<Left><Left><Left>', { noremap = true, silent = true })
-- Mayber not needed?
vim.keymap.set("v", "<leader>y", vim.cmd('"y'))





