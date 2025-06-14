local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region KEYMAPS
--------------------------------------------------------------------------------
keymaps.which_keymap("n", "<leader>dd", "<cmd>DapNew<CR>", "Debug Here")
-- keymaps.which_keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", "Toggle breakpoint")
-- keymaps.which_keymap("n", "<leader>dc", "<cmd>DapContinue<CR>", "Continue")
-- keymaps.which_keymap("n", "<leader>dsi", "<cmd>DapStepInto<CR>", "Step into")
-- keymaps.which_keymap("n", "<leader>do", "<cmd>DapStepOver<CR>", "Step over")
-- keymaps.which_keymap("n", "<leader>dO", "<cmd>DapStepOut<CR>", "Step out")

-- endregion
--------------------------------------------------------------------------------
-- region DAP-UI
--------------------------------------------------------------------------------
local dap_ui_config = function()
  local dap = require("dap")
  -- dap.listeners.after.event_terminated["dapui_config"] = function() end
  -- dap.listeners.after.event_exited["dapui_config"] = function() end
  return {}
end

-- endregion
--------------------------------------------------------------------------------
-- region DAP-PYTHON
--------------------------------------------------------------------------------
local pythonPath = function()
  local cwd = vim.loop.cwd()
  if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    return cwd .. "/.venv/bin/python"
  else
    return "/usr/bin/python"
  end
end

local dap_python_config = function()
  local dap = require("dap")
  local dap_python = require("dap-python")

  dap_python.setup("python")
  dap.configurations.python = {
    -- {
    --   name = "Launch file",
    --   type = "python",
    --   request = "launch",
    --   program = "${file}",
    --   -- pythonPath = venv_python_path(),
    -- },
    {
      name = "django",
      type = "debugpy",
      request = "launch",
      program = "${workspaceFolder}/manage.py",
      args = {
        "runserver",
      },
      justMyCode = true,
      django = true,
      console = "integratedTerminal",
      -- pythonPath = venv_python_path(),
    },
    {
      name = "pytest",
      type = "debugpy",
      request = "launch",
      module = "pytest",
      args = function()
        print(pythonPath())
        local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")

        -- Find the nearest function starting with `def`
        local func_line_num = vim.fn.search("def ", "bcnW")
        local func_line = vim.fn.getline(func_line_num)
        local func_name = func_line:match("def%s+([%w_]+)")

        return {
          current_file_path,
          "-n0",
          "-s",
          "--no-header",
          "--no-cov",
          "--disable-warnings",
          "-p no:sugar",
          -- "--pdb",
          -- "--pdbcls=debugpy:Pdb",
          "-k",
          func_name,
        }
      end,
      justMyCode = true,
      django = true,
      console = "integratedTerminal",
      -- pythonPath = pythonPath(),
    },
  }

  dap.adapters.python = {
    type = "executable",
    -- command = venv_python_path(),
    args = { "-m", "debugpy.adapter" },
  }
end
-- endregion
--------------------------------------------------------------------------------
-- region DAP-PYTHON
--------------------------------------------------------------------------------
local dap_js_config = function()
  local dap = require("dap")
  -- dap.adapters["pwa-node"] = {
  --   type = "server",
  --   host = "localhost",
  --   port = 9229,
  --   executable = {
  --     command = "node",
  --     args = { "/path/to/vscode-js-debug/out/src/vsDebugServer.js", "9229" },
  --   },
  -- }

  dap.configurations.typescript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest",
      program = "${workspaceFolder}/node_modules/.bin/jest",
      args = function()
        local current_file = vim.fn.expand("%:t")
        local args = { "--runInBand", "--no-cache", "-i", current_file, "--testTimeout", "100000" }

        -- Search for the nearest line containing `it(` in the buffer
        local get_test_name = function()
          local it_line_num = vim.fn.search("it('", "bcnW")
          if it_line_num > 0 then
            local it_line = vim.fn.getline(it_line_num)
            -- Extract the value inside quotes
            local test_name = it_line:match("it%(.*'")
            test_name = string.sub(test_name, 5, -2)
            return test_name
          end
          return nil
        end

        local test_name = get_test_name()
        print(test_name)
        if test_name then
          table.insert(args, "-t")
          table.insert(args, test_name)
        end
        for _, arg in ipairs(args) do
          print(arg)
        end

        return args
      end,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      cwd = vim.fn.getcwd(),
    },
  }
  dap.configurations.javascript = dap.configurations.typescript
  dap.listeners.after.event_terminated["dapui_config"] = nil
  dap.listeners.after.event_exited["dapui_config"] = nil
end
-- endregion
--------------------------------------------------------------------------------

return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.32 },
            { id = "watches", size = 0.38 },
            { id = "breakpoints", size = 0.20 },
            { id = "stacks", size = 0.10 },
          },
          size = 70, -- The size of the panel (height or width depending on position)
          position = "right",
        },
        {
          elements = {
            { id = "console", size = 1 },
          },
          size = 10,
          position = "bottom",
        },
      },
    },
    -- config = function(_, opts)
    --   local dap = require("dap")
    --   local dapui = require("dapui")
    --   dapui.setup(opts)
    --   dap.listeners.after.event_initialized["dapui_config"] = function()
    --     dapui.open({})
    --   end
    --   dap.listeners.before.event_terminated["dapui_config"] = function() end
    --   dap.listeners.before.event_exited["dapui_config"] = function() end
    -- end,
  },
  {
    "mfussenegger/nvim-dap",
    config = dap_ui_config,
    -- config = function()
    --   -- load mason-nvim-dap here, after all adapters have been setup
    --   if LazyVim.has("mason-nvim-dap.nvim") then
    --     require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    --   end
    --
    --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --   for name, sign in pairs(LazyVim.config.icons.dap) do
    --     sign = type(sign) == "table" and sign or { sign }
    --     vim.fn.sign_define(
    --       "Dap" .. name,
    --       { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --     )
    --   end
    -- end,
    -- swap step out and step over keymaps since I use step over more often
    keys = {
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = dap_python_config,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    config = dap_js_config,
  },
  -- It is highly recommended to use lazydev.nvim to enable type checking for
  -- nvim-dap-ui to get type checking, documentation and autocompletion for
  -- all API functions.
  -- {
  --   "folke/lazydev.nvim",
  --   opts = {
  --     library = {
  --       plugins = { "nvim-dap-ui" },
  --       types = true,
  --     },
  --   },
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function() end,
  -- },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --     "mfussenegger/nvim-dap-python",
  --     "nvim-neotest/nvim-nio",
  --     "theHamsta/nvim-dap-virtual-text",
  --     "folke/lazydev.nvim",
  --   },
  --   config = dap_ui_config,
  -- },
}
