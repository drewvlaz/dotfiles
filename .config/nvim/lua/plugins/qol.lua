local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region ZEN-MODE
--------------------------------------------------------------------------------

keymaps.which_keymap("n", "<leader>z", "<cmd>ZenMode<CR>", "Toggle zen mode")

local zen_mode_opts = {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 0.85, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      cursorline = true, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
      -- you may turn on/off statusline in zen mode by setting 'laststatus'
      -- statusline will be shown only if 'laststatus' == 3
      laststatus = 0, -- turn off the statusline in zen mode
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = true }, -- disables the tmux statusline
    todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
    gitblame = { enabled = false }, -- disable git-blame.vim
    wezterm = {
      enabled = false,
      -- can be either an absolute font size or the number of incremental steps
      font = "+4", -- (10% increase per step)
    },
  },
  on_open = function(win)
    vim.api.nvim_command("GitBlameDisable")
  end,
  on_close = function(win)
    vim.api.nvim_command("GitBlameEnable")
  end,
}

-- endregion
--------------------------------------------------------------------------------

return {
  {
    "drewvlaz/zen-mode.nvim",
    opts = zen_mode_opts,
  },
  -- {
  --   "folke/twilight.nvim",
  --   opts = {
  --     dimming = {
  --       alpha = 0.20, -- amount of dimming
  --       -- we try to get the foreground from the highlight groups or fallback color
  --       color = { "Normal", "#ffffff" },
  --       term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
  --       inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  --     },
  --     context = 12, -- amount of lines we will try to show around the current line
  --     treesitter = true, -- use treesitter when available for the filetype
  --     -- treesitter is used to automatically expand the visible text,
  --     -- but you can further control the types of nodes that should always be fully expanded
  --     expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
  --       "function",
  --       "method",
  --       "table",
  --       "if_statement",
  --     },
  --     exclude = {}, -- exclude these filetypes
  --   },
  -- },
}
