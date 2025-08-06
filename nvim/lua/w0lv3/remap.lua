vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_set_keymap("n", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<Left><Left><Left>', { noremap = true, silent = true })
-- Mayber not needed?
vim.keymap.set("v", "<leader>y", vim.cmd('"y'))


-- test for remaps
local function interactive_replace()
  local find_text = vim.fn.input('Find: ')
  if find_text == '' then
    print('Cancelled')
    return
  end
  local replace_text = vim.fn.input('Replace "' .. find_text .. '" with: ')
  local flags = vim.fn.input('Flags (gc): ', 'gc')
  
  -- Escape special characters
  find_text = vim.fn.escape(find_text, '/\\^$.*~[]')
  replace_text = vim.fn.escape(replace_text, '/\\~&')
  
  vim.cmd('%s/' .. find_text .. '/' .. replace_text .. '/' .. flags)
end

-- Create the keymap
vim.keymap.set('n', '<leader>fr', interactive_replace, { desc = 'Interactive find and replace' })
