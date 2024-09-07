local keymaps = require("config.keymaps")

--------------------------------------------------------------------------------
-- region COPILOT
--------------------------------------------------------------------------------
keymaps.keymap("i", "<C-l>", "copilot#Accept()", { expr = true, replace_keycodes = false })

-- endregion
--------------------------------------------------------------------------------
-- region COPILOT CHAT
--------------------------------------------------------------------------------
keymaps.keymap("v", "<leader>ce", "<cmd>CopilotChatExplain<CR>")
keymaps.keymap("v", "<leader>cF", "<cmd>CopilotChatFix<CR>")
keymaps.keymap("v", "<leader>cr", "<cmd>CopilotChatReview<CR>")
keymaps.keymap("v", "<leader>ct", "<cmd>CopilotChatTests<CR>")

-- endregion
--------------------------------------------------------------------------------

return {
  {
    "github/copilot.vim",
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = false,
      show_help = "yes",
      prompts = {
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
