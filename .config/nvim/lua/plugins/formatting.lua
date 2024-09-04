return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      typescript = { "prettier", "eslint" },
      typescriptreact = { "prettier", "eslint" },
      python = { "isort", "black" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout = 1000,
    -- },
  },
}
