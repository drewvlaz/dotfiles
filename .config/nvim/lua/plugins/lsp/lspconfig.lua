-- Mostly copied from https://www.josean.com/posts/how-to-setup-neovim-2024
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      -- import mason_lspconfig plugin
      local mason_lspconfig = require("mason-lspconfig")

      -- Get default capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Applied to every server config as a base (mason-lspconfig v2's
      -- `automatic_enable` starts clients via `vim.lsp.enable()` directly and
      -- does not consult a `handlers` table, so per-server capabilities must
      -- go through `vim.lsp.config` instead).
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

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

          local function open_telescope_picker(picker, telescope_opts)
            require("telescope.builtin")[picker]({
              layout_strategy = telescope_opts.strategy or "horizontal",
              layout_config = telescope_opts.config or {
                horizontal = { preview_width = 0.6, results_width = 0.8, preview_cutoff = 1 },
                vertical = { preview_height = 0.5, results_height = 0.8, preview_cutoff = 1 },
              },
              -- Clear the ignore patterns to allow searching node_modules
              file_ignore_patterns = {},
              path_display = { "smart" },
            })
          end

          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gr", custom_lsp_references, opts) -- show definition, references

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- telescope has no lsp_declarations picker

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

      vim.diagnostic.config({
        underline = true,
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Only valid Ruff rule codes — unknown selectors (e.g. flake8's W503/W504)
      -- cause the native server to reject the entire editor ignore list.
      local py_ignored = {
        "E501", -- line too long
        "UP045", -- allow Optional[X] (instead of X | None)
      }

      -- Native `ruff server` rejects deprecated `args` and then ignores the
      -- rest of the editor settings (including lint.ignore). Use lint.* keys.
      vim.lsp.config("ruff", {
        init_options = {
          settings = {
            lint = {
              extendSelect = { "DJ" }, -- Django-specific rules
              ignore = py_ignored,
            },
          },
        },
      })

      -- Sort/organize imports via ruff (isort-compatible) on save. Requested
      -- synchronously so the sorted imports land in the buffer before the
      -- write happens, rather than racing an async code action against it.
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function(args)
          local client = vim.lsp.get_clients({ bufnr = args.buf, name = "ruff" })[1]
          if not client then
            return
          end

          local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
          params.context = { only = { "source.organizeImports" }, diagnostics = {} }

          local response = client:request_sync("textDocument/codeAction", params, 1000, args.buf)
          if not response or not response.result then
            return
          end

          for _, action in ipairs(response.result) do
            -- Ruff returns the action unresolved (no `edit`/`command`, just
            -- opaque `data`) and expects a codeAction/resolve round-trip.
            if not action.edit and not action.command then
              local resolved = client:request_sync("codeAction/resolve", action, 1000, args.buf)
              action = (resolved and resolved.result) or action
            end

            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            elseif action.command then
              client:exec_cmd(action.command, { bufnr = args.buf })
            end
          end
        end,
      })

      local ts_prefs = {
        importModuleSpecifierPreference = "relative",
        importModuleSpecifierEnding = "minimal",
        quotePreference = "auto",
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeAutomaticOptionalChainCompletions = true,
        includeCompletionsWithClassMemberSnippets = true,
        includeCompletionsWithObjectLiteralMethodSnippets = true,
      }
      vim.lsp.config("ts_ls", {
        init_options = { preferences = ts_prefs },
        settings = {
          typescript = { preferences = ts_prefs },
          javascript = { preferences = ts_prefs },
        },
      })

      -- Resolve the poetry-managed venv's interpreter so pyright can see
      -- packages like fastapi that aren't installed on the system python.
      local function resolve_python_path(root_dir)
        local poetry_dir = root_dir
        if vim.fn.filereadable(root_dir .. "/backend/pyproject.toml") == 1 then
          poetry_dir = root_dir .. "/backend"
        elseif vim.fn.filereadable(root_dir .. "/pyproject.toml") == 0 then
          return nil
        end

        local venv = vim.fn.system({ "poetry", "-C", poetry_dir, "env", "info", "--path" })
        if vim.v.shell_error ~= 0 then
          return nil
        end
        venv = vim.trim(venv)

        local python_path = venv .. "/bin/python"
        if venv ~= "" and vim.fn.executable(python_path) == 1 then
          return python_path
        end
        return nil
      end

      vim.lsp.config("pyright", {
        before_init = function(_, config)
          local python_path = resolve_python_path(config.root_dir)
          if python_path then
            config.settings.python.pythonPath = python_path
          end
        end,
        settings = {
          python = {
            disableOrganizeImports = true,
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
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
            diagnosticSeverityOverrides = {
              reportImplicitBool = "error", -- Enables the bool-truthy linting check
            },
          },
        },
      })

      vim.lsp.config("emmet_ls", {
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      })

      vim.lsp.config("lua_ls", {
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

      mason_lspconfig.setup({
        ensure_installed = {
          "ts_ls",
          "ruff",
          "pyright",
          "lua_ls",
          "emmet_ls",
        },
        automatic_enable = true,
        automatic_installation = true,
      })
    end,
  },
}
