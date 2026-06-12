require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Code Runner
map('n', 'rc', ':RunCpp<CR>', { desc = " Compile Run C++ File"})
map('n','rp', ':RunPython<CR>', {desc = "Compile Run Python File"})
map('n', 'cr', ':RunRust<CR>', {desc = "Compile Run Rust File"})
map('n', 'jv', ':RunJava<CR>', { desc = "Compile Run Java File" })
-- Auto Executor - Space+r to automatically detect and run
map('n', '<leader>r', ':AutoExecute<CR>', { desc = "Auto-execute based on file type" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
