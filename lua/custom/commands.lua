vim.api.nvim_create_user_command('RunCargo', function()
  require("nvchad.term").runner {
      pos = "sp",
      cmd = "cargo run",
      id = "ekk",
      clear_cmd = false
  }
end, {})


