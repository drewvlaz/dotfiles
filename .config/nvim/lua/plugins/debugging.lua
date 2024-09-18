local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region KEYMAPS
--------------------------------------------------------------------------------
keymaps.which_keymap("n", "<leader>dd", "<cmd>DapNew<CR>", "Debug Here")
-- keymaps.which_keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", "Toggle breakpoint")
-- keymaps.which_keymap("n", "<leader>dc", "<cmd>DapContinue<CR>", "Continue")
-- keymaps.which_keymap("n", "<leader>dsi", "<cmd>DapStepInto<CR>", "Step into")
-- keymaps.which_keymap("n", "<leader>dso", "<cmd>DapStepOver<CR>", "Step over")
-- keymaps.which_keymap("n", "<leader>dsc", "<cmd>DapStepOut<CR>", "Step out")

-- endregion
--------------------------------------------------------------------------------
-- region DAP-UI
--------------------------------------------------------------------------------
local dap_ui_config = function()
  local config = {
    -- layouts = {
    --   {
    --     -- Define the sidebar layout
    --     elements = {
    --       { id = "scopes", size = 0.25 }, -- 25% of the sidebar height
    --       { id = "breakpoints", size = 0.15 },
    --       { id = "stacks", size = 0.25 },
    --       { id = "watches", size = 0.25 },
    --     },
    --     size = 60, -- Sidebar width
    --     position = "left", -- Sidebar position
    --   },
    --   {
    --     -- Define the tray layout (bottom)
    --     elements = {
    --       { id = "repl", size = 0.5 }, -- 50% of the tray height
    --       { id = "console", size = 0.5 },
    --     },
    --     size = 10, -- Tray height
    --     position = "bottom", -- Tray position
    --   },
    -- },
    -- floating = {
    --   max_height = nil, -- Adjust floating windows' height
    --   max_width = nil, -- Adjust floating windows' width
    --   border = "single", -- Floating window border style
    --   mappings = {
    --     close = { "q", "<Esc>" }, -- Key mappings to close floating windows
    --   },
    -- },
  }
  return config
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
    {
      name = "Launch file",
      type = "python",
      request = "launch",
      program = "${file}",
      -- pythonPath = venv_python_path(),
    },
    {
      name = "Django",
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
      name = "Pytest",
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
          "--no-cov",
          "-p no:sugar",
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

return {
  {
    "rcarriga/nvim-dap-ui",
    -- config = dap_ui_config,
  },
  {
    "mfussenegger/nvim-dap",
    -- config = function() end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = dap_python_config,
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
