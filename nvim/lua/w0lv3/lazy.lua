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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	'folke/which-key.nvim',
	{'folke/neoconf.nvim', cmd = 'Neoconf'},
  'folke/neodev.nvim',

  -- LSP
  {	
    'nvim-telescope/telescope.nvim', 
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  'ThePrimeagen/harpoon',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'VonHeikemen/lsp-zero.nvim',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'hrsh7th/vim-vsnip',
  'hrsh7th/vim-vsnip-integ',
  'L3MON4D3/LuaSnip',


  -- Util
  'mbbill/undotree',

	-- Pretty
	{
    		'nvim-lualine/lualine.nvim',
    		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
  { "rose-pine/neovim", name = "rose-pine" }
})
