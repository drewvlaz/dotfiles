-- Trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_max_chars = 150
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.g.qs_enable = 1

return {
  { "ThePrimeagen/harpoon" },
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
      leap.opts.safe_labels = {}
      leap.opts.case_sensitive = false
      leap.opts.highlight_unlabeled_phase_one_targets = true
      -- leap.add_default_mappings(true)
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.del({ "x", "o" }, "f")
      vim.keymap.del({ "x", "o" }, "F")
      vim.keymap.del({ "x", "o" }, "t")
      vim.keymap.del({ "x", "o" }, "T")
    end,
  },
  {
    "unblevable/quick-scope",
    config = function()
      vim.cmd([[
        highlight QuickScopePrimary guifg=#ff4af0 gui=underline ctermfg=155 cterm=underline
        highlight QuickScopeSecondary guifg=#5fff5f gui=underline ctermfg=81 cterm=underline
      ]])
    end,
  },
}
