local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region HARPOON
--------------------------------------------------------------------------------
local harpoon_config = function()
  local harpoon = require("harpoon")
  harpoon:setup({
    settings = {
      save_on_toggle = true,
      save_on_ui_close = true,
    },
  })

  --- HELPER FUNCTIONS ---
  local get_current_branch = function()
    local pipe = io.popen("git branch --show-current")
    local buffer_size = 1024
    if not pipe then
      return
    end

    local branch_name = pipe:read(buffer_size)
    pipe:close()
    return branch_name
  end

  local add_file = function()
    harpoon:list(get_current_branch()):add()
  end

  local view_files = function()
    local ui_toggle_opts = {
      border = "rounded",
      title_pos = "center",
      ui_width_ratio = 0.60,
    }
    harpoon.ui:toggle_quick_menu(harpoon:list(get_current_branch()), ui_toggle_opts)
  end

  local select_file = function(i)
    harpoon:list(get_current_branch()):select(i)
  end

  --- KEYMAPS ---
  keymaps.which_keymap("n", "<leader>hA", add_file, "Add file")
  keymaps.which_keymap("n", "<leader>hv", view_files, "View files")

  for i = 1, 9 do
    local key = string.format("<leader>h%s", string.char(96 + i))
    local action = function()
      select_file(i)
    end
    keymaps.which_keymap("n", key, action, string.format("Goto file %d", i))
  end

  return {}
end

-- endregion
--------------------------------------------------------------------------------

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = harpoon_config,
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function()
      local leap = require("leap")
      leap.opts.highlight_unlabeled_phase_one_targets = true
      leap.add_default_mappings(true)
    end,
  },
}

--------------------------------------------------------------------------------
-- region DEPRECATED
--------------------------------------------------------------------------------
-- Trigger a highlight in the appropriate direction when pressing these keys:
-- vim.g.qs_max_chars = 150
-- vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
-- {
--   "unblevable/quick-scope",
--   config = function()
--     vim.cmd([[
--       highlight QuickScopePrimary guifg=#ff4af0 gui=underline ctermfg=155 cterm=underline
--       highlight QuickScopeSecondary guifg=#5fff5f gui=underline ctermfg=81 cterm=underline
--     ]])
--   end,
-- },

-- endregion
--------------------------------------------------------------------------------
