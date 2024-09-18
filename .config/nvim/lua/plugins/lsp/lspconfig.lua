-- Mostly copied from https://www.josean.com/posts/how-to-setup-neovim-2024
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import mason_lspconfig plugin
      local mason_lspconfig = require("mason-lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap -- for conciseness

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf, silent = true }

          -- Telescope lsp functions with custom options
          local lsp_telescope_opts = {
            path_display = { "smart" },
            layout_strategy = "vertical",
          }
          local function custom_lsp_references()
            require("telescope.builtin").lsp_references(
              vim.tbl_extend("keep", { include_declaration = false }, lsp_telescope_opts)
            )
          end
          local function custom_lsp_definitions()
            require("telescope.builtin").lsp_definitions(
              vim.tbl_extend("keep", { jump_type = "never" }, lsp_telescope_opts)
            )
          end

          local function open_telescope_picker(picker, telescope_opts)
            require("telescope.builtin")[picker]({
              layout_strategy = telescope_opts.strategy or "horizontal",
              layout_config = telescope_opts.config or {
                horizontal = { preview_width = 0.6, results_width = 0.8 },
                vertical = { preview_height = 0.5, results_height = 0.8 },
              },
            })
          end

          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gr", custom_lsp_references, opts) -- show definition, references

          -- opts.desc = "Go to definition (with preview)"
          -- keymap.set("n", "gD", custom_lsp_definitions, opts) -- go to declaration
          opts.desc = "Go to declaration"
          keymap.set("n", "gd", function()
            open_telescope_picker("lsp_declarations", lsp_telescope_opts)
          end, opts) -- show lsp definitions

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", function()
            open_telescope_picker("lsp_definitions", lsp_telescope_opts)
          end, opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", function()
            open_telescope_picker("lsp_implementations", lsp_telescope_opts)
          end, opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", function()
            open_telescope_picker("lsp_type_definitions", lsp_telescope_opts)
          end, opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          -- opts.desc = "Show line diagnostics"
          -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local py_ignored = {
        "E501", -- line too long
      }

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["pylsp"] = function()
          local ignored = {
            "E501", -- line too long
          }
          lspconfig["pylsp"].setup({
            capabilities = capabilities,
            settings = {
              pylsp = {
                plugins = {
                  black = { enabled = true },
                  isort = { enabled = true },
                  mypy = { enabled = true },
                  flake8 = {
                    enabled = true,
                    ignore = ignored,
                  },
                  mccabe = { enabled = false },
                  pyflakes = {
                    enabled = true,
                    ignore = ignored,
                  },
                  pycodestyle = {
                    enabled = true,
                    ignore = ignored,
                  },
                },
              },
            },
          })
        end,
        ["pyright"] = function()
          lspconfig["pyright"].setup({
            capabilities = capabilities,
            settings = {
              python = {
                disableOrganizeImports = true,
                analysis = {
                  autoImportCompletions = true,
                  autoSearchPaths = true,
                  diagnosticMode = "workspace",
                  useLibraryCodeForTypes = true,
                  -- logLevel = "Trace",
                  exclude = {
                    "**/node_modules",
                    "**/build",
                    "**/dist",
                  },
                  include = {
                    "src",
                    "tests",
                  },
                },
                ignorePyrightErrors = py_ignored,
              },
            },
          })
        end,
        -- ["svelte"] = function()
        --   -- configure svelte server
        --   lspconfig["svelte"].setup({
        --     capabilities = capabilities,
        --     on_attach = function(client, bufnr)
        --       vim.api.nvim_create_autocmd("BufWritePost", {
        --         pattern = { "*.js", "*.ts" },
        --         callback = function(ctx)
        --           -- Here use ctx.match instead of ctx.file
        --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
        --         end,
        --       })
        --     end,
        --   })
        -- end,
        -- ["graphql"] = function()
        --   -- configure graphql language server
        --   lspconfig["graphql"].setup({
        --     capabilities = capabilities,
        --     filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        --   })
        -- end,
        ["emmet_ls"] = function()
          -- configure emmet language server
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })
    end,
  },
}
