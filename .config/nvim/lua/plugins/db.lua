local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region DB
--------------------------------------------------------------------------------
keymaps.which_keymap("n", "<leader>cD", ":DBUIToggle<CR>", "Toggle DBUI")

vim.g.db_ui_notification_width = 5
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_use_nvim_notify = 1

-- endregion
--------------------------------------------------------------------------------

return {
  {
    "tpope/vim-dadbod",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
