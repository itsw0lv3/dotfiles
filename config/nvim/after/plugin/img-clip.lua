require("img-clip").setup({
  default = {
    dir_path = "attachments",
    use_absolute_path = false,
    relative_to_current_file = false,
  },
})

vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "Paste image from clipboard" })
