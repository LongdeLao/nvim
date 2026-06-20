return {
  -- Mason manages external LSPs/formatters and puts them on Neovim's PATH.
  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = {
        -- LSPs
        "tailwindcss-language-server",
        "typescript-language-server",
        "gopls",
        "rust-analyzer",
        "clangd",
        "jdtls",
        "pyright",
        "html-lsp",
        "css-lsp",

        -- Formatters
        "prettier",
        "black",
        "isort",
        "gofumpt",
        "goimports",
        "clang-format",
        "google-java-format",
        "stylua",
      }

      return opts
    end,
    config = function(_, opts)
      require("mason").setup(opts)
      if vim.env.NVIM_SKIP_MASON_AUTO_INSTALL == "1" then
        return
      end

      local registry = require "mason-registry"
      local function install_missing()
        for _, tool in ipairs(opts.ensure_installed or {}) do
          local ok, package = pcall(registry.get_package, tool)
          if ok and not package:is_installed() then
            package:install()
          end
        end
      end

      if registry.refresh then
        registry.refresh(install_missing)
      else
        install_missing()
      end
    end,
  },

  -- Conform plugin for formatting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- LuaSnip for snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    version = "v2.*",
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
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "go",
        "gomod",
        "gosum",
        "html",
        "java",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "ocaml",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      },
      indent = {enable = true}
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
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
    opts = {
      file_types = { "markdown" },
      latex = { enabled = true },
    },
    ft = { "markdown" },
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
   -- lazy.nvim
   {
    "folke/snacks.nvim",
    ---@type snacks.Config
        lazy = false,
        opts = {
            image = {
                enabled = false,
                math = {enabled = false},
                doc = {inline = false}
                -- your image configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            },
            scroll = {

            },

        }
    },
    {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    lazy = false,
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1 -- Start preview automatically
    end,
  }
}
