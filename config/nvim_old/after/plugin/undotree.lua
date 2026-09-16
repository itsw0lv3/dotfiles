-- vim.keymap.set("n", "<leader>u", vim.cmd.undotreetoggle)

-- New undo tree config testing:
vim.keymap.set("n", "<leader>u", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end)
