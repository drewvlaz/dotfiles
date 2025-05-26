-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-emoji",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     {
--       "L3MON4D3/LuaSnip",
--       version = "v2.*",
--       build = "make install_jsregexp",
--     },
--     "saadparwaiz1/cmp_luasnip",
--     "rafamadriz/friendly-snippets",
--     "onsails/lspkind-nvim",
--     "rcarriga/cmp-dap",
--   },
--   config = function()
--     local cmp = require("cmp")
--     -- local luasnip = require("luasnip")
--     local lspkind = require("lspkind")
--
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     cmp.setup({
--       enabled = function()
--         -- Special case for cmp to work with nvim-dap, see below
--         return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
--       end,
--       completion = {
--         completeopt = "menu,menuone,preview,noinsert",
--       },
--
--       snippet = {
--         expand = function(args)
--           require("luasnip").lsp_expand(args.body)
--         end,
--       },
--
--       mapping = cmp.mapping.preset.insert({
--         ["<CR>"] = cmp.config.disable,
--         ["<C-j>"] = cmp.mapping.select_next_item(),
--         ["<C-k>"] = cmp.mapping.select_prev_item(),
--         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
--         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
--         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--         ["<TAB>"] = cmp.mapping.confirm(),
--       }),
--
--       sources = {
--         -- { name = "supermaven" },
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "buffer" },
--         { name = "path" },
--         { name = "nvim_lsp_signature_help" },
--         { name = "vim-dadbod-completion" },
--       },
--
--       formatting = {
--         format = lspkind.cmp_format({
--           with_text = false,
--           maxwidth = 50,
--           ellipsis_char = "…",
--         }),
--         expandable_indicator = true,
--       },
--
--       -- window = {
--       --   completion = cmp.config.window.bordered(),
--       --   documentation = cmp.config.window.bordered(),
--       -- },
--
--       experimental = {
--         ghost_text = false,
--         native_menu = false,
--       },
--     })
--
--     -- Special case for cmp to work with nvim-dap
--     cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui-hover" }, {
--       sources = cmp.config.sources({
--         { name = "dap" },
--       }, {
--         { name = "buffer" },
--       }),
--     })
--   end,
-- }

local blink_config = function()
  local blink = require("blink.cmp")
  blink.setup({
    sources = {
      default = {
        "lsp",
        -- "luasnip",
        "path",
        "snippets",
        "buffer",
        -- "nvim_lsp_signature_help",
      },
    },
    completion = {
      ghost_text = {
        -- using ghost_text with supermaven instead, if this is enabled
        -- it will have weird visual conflicts
        enabled = false,
      },
      list = { selection = { preselect = true, auto_insert = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 0 },
    },
    cmdline = {
      enabled = false,
      completion = {
        ghost_text = {
          enabled = false,
        },
      },
      keymap = {
        preset = "cmdline",
        ["<CR>"] = {},
      },
    },
    keymap = {
      preset = "enter",
      ["<CR>"] = {},
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
    enabled = function()
      if ({ ["dap-repl"] = true, ["dapui_watches"] = true, ["dapui-hover"] = true })[vim.bo.filetype] then
        ---@diagnostic disable-next-line: return-type-mismatch
        return "force"
      end
      return true
    end,
  })
end

return {
  {
    "saghen/blink.cmp",
    -- dependencies = {
    --   "rcarriga/cmp-dap",
    -- },
    config = blink_config,
  },
}
