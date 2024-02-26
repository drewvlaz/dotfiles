return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
  },

  -- preselect = require("cmp").cmp.PreselectMode.None,

  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    -- local has_words_before = function()
    --   unpack = unpack or table.unpack
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- end

    local luasnip = require("luasnip")
    local cmp = require("cmp")

    opts.snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<CR>"] = cmp.config.disable,
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<TAB>"] = cmp.mapping.confirm(),
    })

    opts.sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lsp_signature_help" },
    }

    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }

    opts.experimental = {
      ghost_text = false,
      native_menu = false,
    }
  end,
}
