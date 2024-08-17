-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pyright",}
local util = require "lspconfig.util"
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

--rust-analyzer
lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}
-- C/C++
lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  cmd = { "clangd", "--background-index" },  -- Custom command with additional options
  filetypes = { "c", "cpp", "objc", "objcpp" },
  -- root_dir function to find the root directory or use the current directory
  root_dir = function(fname)
    -- Try to find the root directory with common project files or directories
    local root_patterns = { "compile_commands.json", "CMakeLists.txt", ".git" }
    return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
  end,
}

-- swift
lspconfig.sourcekit.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "swift" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern("Package.swift", ".git")(fname) or
           lspconfig.util.path.dirname(fname)
  end,
  cmd = { "xcrun", "sourcekit-lsp" },
}




-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
