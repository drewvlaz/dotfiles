local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

-- lspconfig.pyright.setup {
-- 	 settings = {
--       python = {
--         analysis = {
--           typeCheckingMode = "off",
--           autoSearchPaths = true,
--           useLibraryCodeForTypes = true
--         }
--       }
--     }
-- }

mason.setup({
    ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
})

require("mason-lspconfig").setup()
-- require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.config")
-- require("user.lsp.null-ls")


