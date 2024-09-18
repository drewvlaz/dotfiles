return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      lspconfig = mason_lspconfig,
      silent = true,
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls",
        "pyright",
        -- "pylsp",
      },
    })
  end,
}
