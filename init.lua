vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"


-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

require "custom.init"
vim.schedule(function()
  require "mappings"
end)


-- Custom 
vim.opt.relativenumber = true

vim.opt.tabstop = 4       -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4    -- Indentation level when using >> or <<
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.softtabstop = 4   -- Make backspace behave correctly with spaces


vim.opt.conceallevel = 1 
