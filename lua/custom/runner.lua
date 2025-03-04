vim.api.nvim_create_user_command('RunCpp', function()
  local fullFileName = vim.fn.expand('%:p')  -- Full file path of the current file
  local fileNameWithoutExt = vim.fn.expand('%:t:r')  -- File name without extension
  local dir = vim.fn.expand('%:p:h')  -- Directory path of the current file
  local outputExecutable = dir .. fileNameWithoutExt  -- Full path for the executable output

  -- Enclose paths in quotes to handle spaces in directories (e.g., "first last")
  local cmd = string.format("g++ -std=c++20 \"%s\" -o \"%s\" && \"%s\"", fullFileName, outputExecutable, outputExecutable)

  -- Run the command in a split terminal
  require("nvchad.term").runner {
      pos = "sp",  -- Open in a split terminal
      cmd = cmd,  -- Command to run
      id = "cpp_runner",  -- Unique ID for the terminal
      clear_cmd = false  -- Don't clear the terminal after running
  }
end, {})


--latex
vim.api.nvim_create_user_command('CompileLaTeX', function()
  -- Get the full path of the current file
  local fullFileName = vim.fn.expand('%:p')
  -- Get the directory of the current file
  local dir = vim.fn.expand('%:p:h')
  -- Command to change directory and run pdflatex
  local cmd = string.format("cd %s && pdflatex %s", dir, vim.fn.expand('%:t'))

  -- Run the command in a split terminal
  require("nvchad.term").runner {
    pos = "sp",          -- Position: "sp" for split
    cmd = cmd,           -- The command to run
    id = "latex_compiler", -- Unique ID for the terminal
    clear_cmd = false   -- Do not clear the terminal before running
  }
end, {})



vim.api.nvim_create_user_command('RunPython', function()
  -- Get the full file path of the current file
  local fullFileName = vim.fn.expand('%:p')  -- Full file path of the current file

  -- Command to run the Python file
  local cmd = string.format("python3 \"%s\"", fullFileName)

  -- Run the command in a split terminal
  require("nvchad.term").runner {
    pos = "sp",          -- Position: "sp" for split
    cmd = cmd,           -- The command to run
    id = "python_runner", -- Unique ID for the terminal
    clear_cmd = false    -- Do not clear the terminal before running
  }
end, {})

