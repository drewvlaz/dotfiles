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
    enabled = true,
    -- opts = function(_, opts)
    --   return vim.tbl_deep_extend("force", opts, {
    --     lsp = {
    --       signature = {
    --         auto_open = { enabled = false },
    --       },
    --     },
    --     cmdline = {
    --       enabled = true,
    --       view = "cmdline",
    --     },
    --   })
    -- end,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    version = "1.6.68",
    config = function()
      require("grug-far").setup({})
    end,
  },
}
