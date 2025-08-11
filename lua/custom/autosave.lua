vim.g.autosave = true
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = vim.api.nvim_create_augroup("Autosave", {}),
  nested = true,
  callback = function()
    local buftype = vim.bo.buftype

    -- Only save if the buffer is a normal file (not a terminal, help file, etc.)
    if vim.g.autosave
      and buftype == ""
      and #vim.api.nvim_buf_get_name(0) ~= 0
      and vim.bo.buflisted
      and not vim.bo.readonly -- do not try to save readonly files
      and vim.bo.modifiable    -- skip non-modifiable buffers
    then
      -- Use :silent! update so we don't echo and we only write if the buffer changed
      vim.cmd "silent! update"
      vim.api.nvim_echo({ { "󰄳", "LazyProgressDone" }, { " file autosaved at " .. os.date "%I:%M %p" } }, false, {})


      -- clear msg after 800ms
      vim.defer_fn(function()
        vim.api.nvim_echo({}, false, {})
      end, 800)
    end
  end,
})

vim.api.nvim_create_user_command("AutosaveToggle", function()
  vim.g.autosave = not vim.g.autosave
end, {})
