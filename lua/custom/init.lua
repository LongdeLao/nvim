local plugins = {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      -- Define the natural_cmp function with version number support
      local function natural_cmp(left, right)
        local l_name = left.name:lower()
        local r_name = right.name:lower()

        if l_name == r_name then
          return false
        end

        -- Split by dots into segments
        local l_segments = {}
        local r_segments = {}
        for segment in l_name:gmatch("[^.]+") do
          table.insert(l_segments, segment)
        end
        for segment in r_name:gmatch("[^.]+") do
          table.insert(r_segments, segment)
        end

        -- Compare each segment
        for i = 1, math.max(#l_segments, #r_segments) do
          local l_seg = l_segments[i] or ""
          local r_seg = r_segments[i] or ""

          -- If both segments are numeric, compare as numbers
          local l_num = tonumber(l_seg)
          local r_num = tonumber(r_seg)
          if l_num and r_num then
            if l_num ~= r_num then
              return l_num < r_num
            end
          else
            -- Otherwise, compare as strings
            if l_seg ~= r_seg then
              return l_seg < r_seg
            end
          end
        end

        return false -- Equal if all segments match
      end

      -- Ensure the sort table exists
      opts.sort = opts.sort or {}
      -- Apply the sorter
      opts.sort.sorter = function(nodes)
        table.sort(nodes, natural_cmp)
      end

      -- Return the modified opts table
      return opts
    end,
  },
}

require "custom.autosave"
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/custom/snippets"})
require "configs.runner"

-- Guard markdown code-fence injections on Neovim 0.12, where the capture can be wrapped.
local function patch_markdown_info_string_directive()
  local ok, query = pcall(require, "vim.treesitter.query")
  if not ok then
    return
  end

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = match[pred[2]]
    if type(node) == "table" then
      node = node[1]
    end
    if not node or type(node.range) ~= "function" then
      return
    end

    local ok_text, lang = pcall(vim.treesitter.get_node_text, node, bufnr)
    if not ok_text or not lang or lang == "" then
      return
    end

    lang = lang:lower()
    local aliases = {
      ex = "elixir",
      pl = "perl",
      sh = "bash",
      ts = "typescript",
    }
    metadata["injection.language"] = vim.filetype.match({ filename = "a." .. lang })
      or aliases[lang]
      or lang
  end, { force = true, all = false })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(args)
    if args.data == "nvim-treesitter" then
      patch_markdown_info_string_directive()
    end
  end,
})

patch_markdown_info_string_directive()
return plugins
