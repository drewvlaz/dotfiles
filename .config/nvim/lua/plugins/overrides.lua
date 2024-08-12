return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox-material",
      colorscheme = "everforest",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        -- ["<leader>f"] = {
        --   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        -- },
        ["<leader>d"] = { name = "document" },
        ["<leader>h"] = { name = "harpoon" },
      },
    },
  },
}
