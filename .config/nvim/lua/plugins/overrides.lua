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
        {
          "<leader>C",
          group = "coverage",
        },
        {
          "<leader>d",
          group = "debug",
        },
        {
          "<leader>h",
          group = "harpoon",
        },
      },
    },
  },
}
