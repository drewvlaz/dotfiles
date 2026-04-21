local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region COPILOT
--------------------------------------------------------------------------------
-- keymaps.keymap("i", "<C-l>", "copilot#Accept()", { expr = true, replace_keycodes = false })

-- endregion
--------------------------------------------------------------------------------
-- region COPILOT CHAT
--------------------------------------------------------------------------------
keymaps.which_keymap("v", "<leader>ce", "<cmd>CopilotChatExplain<CR>", "Copilot Explain")
-- keymaps.which_keymap("v", "<leader>cF", "<cmd>CopilotChatFix<CR>", "Copilot Fix")
keymaps.which_keymap("v", "<leader>cr", "<cmd>CopilotChatRefactor<CR>", "Copilot Refactor")
keymaps.which_keymap("v", "<leader>cR", "<cmd>CopilotChatReview<CR>", "Copilot Review")
keymaps.which_keymap("v", "<leader>cs", "<cmd>CopilotChatFix<CR>", "Copilot Suggest Fix")
keymaps.which_keymap("v", "<leader>ct", "<cmd>CopilotChatTests<CR>", "Copilot Tests")

-- endregion
--------------------------------------------------------------------------------
-- region SUPERMAVEN
--------------------------------------------------------------------------------
local supermaven_config = function()
  require("supermaven-nvim").setup({
    keymaps = {
      accept_suggestion = "<C-l>",
      clear_suggestion = "<C-h>",
      accept_word = "<C-e>",
    },
    -- ignore renaming files in file explorer
    ignore_filetypes = {
      "neo-tree",
    },
    color = {
      suggestion_color = "#ffb996",
      cterm = 244,
    },
    log_level = "off", -- set to "off" to disable logging completely
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false, -- disables built in keymaps for more manual control
    -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    condition = function()
      -- TODO: Stop if buffer is too large
      return false
    end,
  })
end

--------------------------------------------------------------------------------

return {
  -- {
  --   "github/copilot.vim",
  -- },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "canary",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --   },
  --   build = "make tiktoken", -- Only on MacOS or Linux
  --   opts = {
  --     debug = false,
  --     show_help = "yes",
  --     prompts = {
  --       Explain = "Explain how this code works please.",
  --       Review = "Review the following code and provide concise suggestions please.",
  --       Tests = ([[
  --           Briefly explain how the selected code works, then generate unit tests please.
  --           When generating unit tests, please use pytest (with @pytest.mark.django_db)
  --           and use custom factories (define make_ functions) to generate the necessary data
  --         ]]):gsub("[\n\t]", ""):gsub("^%s*(.-)%s*$", "%1"),
  --       Refactor = "Refactor the code to improve clarity and readability please.",
  --     },
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
  {
    "supermaven-inc/supermaven-nvim",
    config = supermaven_config,
  },
}
