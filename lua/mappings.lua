require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set



-- Code Runner 
map("n", "<leader>cr", "<cmd>RunCargo<CR>", { desc = "Run Cargo " })
map("n", "g++","<cmd>RunCpp<CR>", {desc = "Run C++"})
map("n", "gcc","<cmd>RunC<CR>", {desc = "Run C"})
map("n", "<leader>sw", "<cmd>RunSwift<CR>", {desc = "Run Swift"})




--defaults 
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
