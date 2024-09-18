local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region GIT-BLAME
--------------------------------------------------------------------------------
keymaps.which_keymap("n", "<leader>ga", "<cmd>GitBlameToggle<CR>", "Toggle author blame")
keymaps.which_keymap("n", "<leader>gb", "<cmd>GitBlameOpenCommitURL<CR>", "Open in browser")

-- TODO: figure out why these work as global vars but not in opts
-- vim.g.gitblame_message_template = "     (<date>) • <summary>"
vim.g.gitblame_message_template = "     <author> (<date>) • <summary>"
vim.g.gitblame_date_format = "%m-%d-%Y"
vim.g.gitblame_highlight_group = "Label"
vim.g.gitblame_set_extmark_options = {
  hl_mode = "combine",
}

-- endregion
--------------------------------------------------------------------------------

return {
  "f-person/git-blame.nvim",
  -- load the plugin at startup
  event = "VeryLazy",
  -- Because of the keys part, you will be lazy loading this plugin.
  -- The plugin wil only load once one of the keys is used.
  -- If you want to load the plugin at startup, add something like event = "VeryLazy",
  -- or lazy = false. One of both options will work.
  opts = {
    enabled = true, -- if you want to enable the plugin
    virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    display_virtual_text = 1, -- virtual text
  },
}
