return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      typescript = { "prettier", "eslint" },
      typescriptreact = { "prettier", "eslint" },
      python = { "ruff_fix", "ruff_format" },
      rust = { "rustfmt" },
    },
  },
}
