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
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.signature = {
        auto_open = { enabled = false },
      }
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    version = "1.6.3",
    config = function()
      require("grug-far").setup({})
    end,
  },
}
