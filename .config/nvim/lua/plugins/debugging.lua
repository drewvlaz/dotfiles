--------------------------------------------------------------------------------
-- region DAP
--------------------------------------------------------------------------------
local dap_config = function()
  -- It is highly recommended to use lazydev.nvim to enable type checking for
  -- nvim-dap-ui to get type checking, documentation and autocompletion for
  -- all API functions.
  -- require("lazydev").setup({
  --   library = { plugins = { "nvim-dap-ui" }, types = true },
  -- })

  local dap = require("dap")
  local dapui = require("dapui")
  local dap_python = require("dap-python")

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  dap_python.setup("python")
  dap_python.test_runner = "pytest"
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        return ".venv/bin/python3"
      end,
    },
  }
end

-- endregion
--------------------------------------------------------------------------------

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",

      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",

      "folke/lazydev.nvim",
    },
    config = dap_config,
  },
}
