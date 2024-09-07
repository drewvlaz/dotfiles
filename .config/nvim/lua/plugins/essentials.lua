return {
  {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
  },
}

--------------------------------------------------------------------------------
-- region DEPRECATED
--------------------------------------------------------------------------------

-- Vimtex --
-- keymap("n", "<leader>dc", "<cmd>VimtexCompile<CR>", whichkey_opts("Compile"))
-- keymap("n", "<leader>df", "<cmd>VimtexClean<CR>", whichkey_opts("Clean"))
-- keymap("n", "<leader>de", "<cmd>VimtexErrors<CR>", whichkey_opts("Errors"))
-- keymap("n", "<leader>ds", "<cmd> set spell! spell?<CR>", whichkey_opts("Toggle spelling"))

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

-- endregion
--------------------------------------------------------------------------------
