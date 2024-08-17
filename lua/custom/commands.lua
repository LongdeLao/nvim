
--cargo run
vim.api.nvim_create_user_command('RunCargo', function()
  -- Use the predefined variables
  local fullFileName = vim.fn.expand('%:p')
  local fileNameWithoutExt = vim.fn.expand('%:t:r')
  local dir = vim.fn.expand('%:p:h') .. "/"
  local cmd = string.format("cd %s && cargo run", dir)
  require("nvchad.term").runner {
      pos = "sp",
      cmd = cmd,
      id = "cargo_runner",
      clear_cmd = false
  }
end, {})

--g++ for c++
vim.api.nvim_create_user_command('RunCpp', function()

  local fullFileName = vim.fn.expand('%:p')
  local fileNameWithoutExt = vim.fn.expand('%:t:r')
  local dir = vim.fn.expand('%:p:h') .. "/"
  local cmd = string.format("g++ -std=c++17 %s -o %s && %s%s", fullFileName, fileNameWithoutExt, dir, fileNameWithoutExt)
  require("nvchad.term").runner {
      pos = "sp",
      cmd = cmd,
      id = "cpp_runner",
      clear_cmd = false
  }
end, {})

--gcc for c
vim.api.nvim_create_user_command('RunC', function()
  -- Command to compile and run C code local fullFileName = vim.fn.expand('%:p')
  local fullFileName = vim.fn.expand('%:p')
  local fileNameWithoutExt = vim.fn.expand('%:t:r')
  local dir = vim.fn.expand('%:p:h') .. "/"

  local cmd = string.format("gcc %s -o %s && %s%s", fullFileName, fileNameWithoutExt, dir, fileNameWithoutExt)

  require("nvchad.term").runner {
      pos = "sp",
      cmd = cmd,
      id = "c_runner",
      clear_cmd = false
  }
end, {})

--swift 
vim.api.nvim_create_user_command('RunSwift', function()
  local fullFileName = vim.fn.expand('%:p')  -- Get the full path of the current file

  -- Command to compile and run the Swift file
  local cmd = string.format("swift %s", fullFileName)

  -- Run the command in a terminal split
  require("nvchad.term").runner {
    pos = "sp",        -- Open in a horizontal split
    cmd = cmd,         -- Command to run
    id = "swift_runner", -- Identifier for the terminal
    clear_cmd = false  -- Do not clear the command after execution
  }
end, {})

