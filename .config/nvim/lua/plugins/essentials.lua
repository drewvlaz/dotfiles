return {
  {
    "github/copilot.vim",
    config = function()
      vim.cmd([[highlight CopilotSuggestion guifg=#ffb996 ctermfg=8]])
    end,
  },
  -- {
  --   "lervag/vimtex",
  --   ft = { "tex" },
  --
  --   config = function()
  --     -- vim.g.vimtex_view_general_viewer = "zathura"
  --     vim.g.vimtex_view_general_viewer = "evince"
  --     vim.g.vimtex_format_enabled = false
  --     vim.g.vimtex_indent_enabled = false
  --     vim.g.vimtex_compiler_latexmk = {
  --       -- build_dir = '',
  --       -- callback = 1,
  --       -- continuous = 1,
  --       -- executable = 'pdflatex',
  --       -- hooks = {},
  --       options = {
  --         "-shell-escape",
  --         -- '-verbose',
  --         "-quiet",
  --         "-file-line-error",
  --         "-synctex=1",
  --         "-interaction=nonstopmode",
  --       },
  --     }
  --     -- vim.g.livepreview_previewer = "evince"
  --     vim.g.livepreview_cursorhold_recompile = 0
  --   end,
  -- },
  { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" },
}
