local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region Coverage
--------------------------------------------------------------------------------
keymaps.which_keymap("n", "<leader>cc", "<cmd>Coverage<CR>", "Enable code coverage")
keymaps.which_keymap("n", "<leader>Cs", "<cmd>Coverage<CR>", "Show code coverage summary")
keymaps.which_keymap("n", "<leader>Ct", "<cmd>CoverageToggle<CR>", "Toggle code coverage")

-- endregion
--------------------------------------------------------------------------------

return {
  "andythigpen/nvim-coverage",
  opts = {
    commands = true, -- create commands
    highlights = {
      -- customize highlight groups created by the plugin
      covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
      uncovered = { fg = "#F07178" },
    },
    signs = {
      -- use your own highlight groups or text markers
      covered = { hl = "CoverageCovered", text = "▎" },
      uncovered = { hl = "CoverageUncovered", text = "▎" },
    },
    summary = {
      -- customize the summary pop-up
      min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
    },
    lang = {
      -- customize language specific settings
    },
  },
}
