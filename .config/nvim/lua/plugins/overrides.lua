return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        -- ["<leader>f"] = {
        --   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        -- },
        ["<leader>d"] = { name = "document" },
        ["<leader>h"] = { name = "harpoon" },
      },
    },
  },
}
