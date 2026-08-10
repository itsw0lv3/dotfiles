require("obsidian").setup({
  workspaces = {
    {
      name = "Notes",
      path = "~/Documents/Personal/Notes",
    },
  },

  attachments = {
    img_folder = "Assets",
  },

  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },

  ui = {
    enable = true,
    checkboxes = {
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
    },
  },
})
