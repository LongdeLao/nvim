local nvlsp = require "nvchad.configs.lspconfig"

local on_init = function(client, _)
  local supports_semantic_tokens

  if client.supports_method then
    supports_semantic_tokens = client:supports_method "textDocument/semanticTokens"
  else
    supports_semantic_tokens = vim.tbl_get(client.server_capabilities, "semanticTokensProvider") ~= nil
  end

  if supports_semantic_tokens then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("custom_lsp_attach", { clear = true }),
  callback = function(args)
    nvlsp.on_attach(_, args.buf)
  end,
})

local lua_lsp_settings = {
  Lua = {
    runtime = { version = "LuaJIT" },
    workspace = {
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        "${3rd}/luv/library",
      },
    },
  },
}

local servers = {
  "clangd",
  "cssls",
  "gopls",
  "html",
  "jdtls",
  "pyright",
  "rust_analyzer",
  "tailwindcss",
  "ts_ls",
  "lua_ls",
}

local server_configs = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },

  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        gofumpt = true,
        staticcheck = true,
      },
    },
  },

  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },

  tailwindcss = {
    filetypes = {
      "aspnetcorerazor",
      "astro",
      "astro-markdown",
      "blade",
      "clojure",
      "django-html",
      "htmldjango",
      "edge",
      "eelixir",
      "elixir",
      "ejs",
      "erb",
      "eruby",
      "gohtml",
      "gohtmltmpl",
      "haml",
      "handlebars",
      "hbs",
      "html",
      "htmlangular",
      "html-eex",
      "heex",
      "jade",
      "leaf",
      "liquid",
      "markdown",
      "mdx",
      "mustache",
      "njk",
      "nunjucks",
      "php",
      "razor",
      "slim",
      "twig",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "stylus",
      "sugarss",
      "javascript",
      "javascriptreact",
      "reason",
      "rescript",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "templ",
    },
  },

  ts_ls = {
    init_options = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
  },

  lua_ls = {
    settings = lua_lsp_settings,
  },
}

for _, server in ipairs(servers) do
  local config = vim.tbl_deep_extend("force", {
    on_attach = function(client, bufnr)
      if client.name == "tailwindcss" then
        client.server_capabilities.colorProvider = false
      end

      nvlsp.on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = nvlsp.capabilities,
  }, server_configs[server] or {})

  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
