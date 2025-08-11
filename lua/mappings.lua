require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Code Runner
map('n', 'g++', ':RunCpp<CR>', { desc = " Compile Run C++ File"})
map('n','py', ':RunPython<CR>', {desc = "Compile Run Python File"})
map('n', 'rc', ':RunRust<CR>', {desc = "Compile Run Rust File"})
map('n', '<leader>lc', ':CompileLaTeX<CR>', { desc = "Compile LaTeX" })
map('n', 'ocm', ':RunOCaml<CR>', {desc = "Run OCaml File"})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
