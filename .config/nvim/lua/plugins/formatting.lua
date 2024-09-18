return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      typescript = { "prettier", "eslint" },
      typescriptreact = { "prettier", "eslint" },
      python = { "autoflake", "isort", "black" },
    },
    formatters = {
      autoflake = {
        prepend_args = {
          "--remove-all-unused-imports",
          -- "--remove-unused-variables",
        },
      },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout = 1000,
    -- },
  },
}
