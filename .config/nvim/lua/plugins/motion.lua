-- Trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_max_chars = 150
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

return {
  { "ThePrimeagen/harpoon" },
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
