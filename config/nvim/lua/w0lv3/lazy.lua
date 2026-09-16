-- Lazy Install on Launch
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'folke/which-key.nvim', --Keymap helper
  { 'folke/neoconf.nvim', cmd = 'Neoconf' }, -- Project Configs
  -- neodev/lazydev removed for now, look at later
  
  -- LSP:
  {
    'nvim-telescope/telescope.nvim',
    dependancies = {
      'nvim-lua/plenary.nvim'
    }
  },
  'ThePrimeagen/harpoon',
  'mason-org/mason.nvim',
  'mason-org/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'hrsh7th/vim-vsnip',
  'hrsh7th/vim-vsnip-integ',
  'L3MON4D3/LuaSnip',
  'mbbill/undotree',
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },

  -- Make Me Pretty!
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
})
