require("nvchad.term").runner {
  id = "boo",
  pos = "sp",  -- "sp" for split terminal, you can change this to "vert" for a vertical split or "tab" for a new tab

  cmd = function()
    local file = vim.fn.expand "%"

    -- Define commands for different file types
    local ft_cmds = {
      python = "python3 " .. file,
      cpp = "clear && g++ -o out " .. file .. " && ./out",
      rust = "cargo run",  -- Command to run the Rust project using Cargo
    }

    -- Return the appropriate command based on the current filetype
    return ft_cmds[vim.bo.ft]
  end,
}
