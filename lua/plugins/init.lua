return {
  -- Conform plugin for formatting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
      config = function()
      require "configs.lspconfig"
    end,
  },

  -- Treesitter config with a list of languages to ensure installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css","cpp"},
    },
    indent = {enable = true}
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
        enabled = false,  -- Completely disable indent guides
    }
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    lazy = false,
  },
  -- Devicons plugin for file icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {}
  },
  -- Todo comments plugin
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
