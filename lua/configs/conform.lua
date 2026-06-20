local options = {
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    css = { "prettier" },
    go = { "goimports", "gofumpt" },
    html = { "prettier" },
    java = { "google_java_format" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    scss = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    yaml = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
