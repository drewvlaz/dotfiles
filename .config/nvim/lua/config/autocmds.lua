-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     print("Filetype: " .. vim.bo.filetype)
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("prose"),
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indents"),
  pattern = { "typescript", "typescriptreact", "javascript", "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("harpoon_cursorline"),
  pattern = { "harpoon" },
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("neo_tree_buffers"),
--   pattern = { "neo-tree" },
--   callback = function()
--     print("NeoTree popup")
--     vim.keymap.set("n", "d", "<cmd>bd<CR>", { noremap = true, silent = true })
--   end,
-- })

local custom_hi_groups = function()
  local keyword_highlight = vim.api.nvim_get_hl(0, { name = "Keyword" })
  local keyword_groups = {
    "@keyword",
    "@keyword.conditional",
    "@keyword.exception",
    "@keyword.function",
    "@keyword.import",
    "@keyword.repeat",
    "@keyword.return",
  }
  for _, group in ipairs(keyword_groups) do
    vim.api.nvim_set_hl(0, group, { italic = true, fg = keyword_highlight.fg })
  end
  vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true, fg = keyword_highlight.fg })

  local string_highlight = vim.api.nvim_get_hl(0, { name = "String" })
  vim.api.nvim_set_hl(0, "@string", { bold = true, fg = string_highlight.fg })

  local comment_highlight = vim.api.nvim_get_hl(0, { name = "Comment" })
  vim.api.nvim_set_hl(0, "@comment", { italic = true, fg = comment_highlight.fg })
  vim.api.nvim_set_hl(0, "Label", { fg = comment_highlight.fg }) -- special override for git-blame

  -- Transparent backgrounds
  local transparent_groups = {
    "Normal",
    "NormalFloat",
    "FloatBorder",
    "FloatTitle",
    "NormalNC",
    "NonText",
    "SignColumn",
    "EndOfBuffer",
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "NeoTreeFloatBorder",
    "NeoTreeFloatTitle",
    "NeoTreeEndOfBuffer",
  }
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end

  vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#ffb996", bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("color_special_formatting"),
  pattern = "*",
  callback = custom_hi_groups,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("remove_cro"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("c")
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
    vim.cmd("norm zt")
  end,
})
