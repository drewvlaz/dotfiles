local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region LUALINE
--------------------------------------------------------------------------------
local lualine_opts = {
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
    lualine_c = {
      { "filetype", icon_only = true },
      {
        "filename",
        fmt = function(file)
          if file:match("harpoon") then
            return ""
          end
          return vim.fn.expand("%:~:.")
        end,
      },
    },
    -- lualine_x = {},
    -- lualine_z = {},
    -- lualine_y = {},
  },
}

-- endregion
--------------------------------------------------------------------------------
-- region NEOTREE
keymaps.which_keymap("n", "<leader>i", "<cmd>Neotree buffers float toggle<CR>", "Inspect buffers")

-- endregion
--------------------------------------------------------------------------------

return {
  {
    "rcarriga/nvim-notify",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = lualine_opts,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
}
