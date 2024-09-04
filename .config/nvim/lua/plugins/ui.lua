return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_b = {
          {
            "branch",
            fmt = function(branch_name)
              local max_len = 20
              -- Remove everything before the last slash
              local new_name = string.gsub(branch_name, "^.*/", "")
              if string.len(new_name) > max_len then
                return string.sub(new_name, 1, max_len) .. "…"
              else
                return new_name
              end
            end,
          },
        },
      },
    },
  },
}
