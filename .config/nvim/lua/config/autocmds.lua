-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

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
  for _, keyword_group in ipairs(keyword_groups) do
    vim.api.nvim_set_hl(0, keyword_group, { italic = true, fg = keyword_highlight.fg })
  end
  vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true, fg = keyword_highlight.fg })

  local string_highlight = vim.api.nvim_get_hl(0, { name = "String" })
  vim.api.nvim_set_hl(0, "@string", { italic = true, fg = string_highlight.fg })

  local comment_highlight = vim.api.nvim_get_hl(0, { name = "Comment" })
  vim.api.nvim_set_hl(0, "@comment", { italic = true, fg = comment_highlight.fg })
  vim.api.nvim_set_hl(0, "Label", { fg = comment_highlight.fg })

  -- Transparent backgrounds
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#ffb996", bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("color_special_formatting"),
  pattern = "*",
  callback = custom_hi_groups,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("enter_special_formatting"),
  pattern = "*",
  callback = custom_hi_groups,
})

-- vim.api.nvim_create_autocmd("InsertEnter", {
--   group = augroup("center_on_insert"),
--   pattern = "*",
--   callback = function()
--     vim.cmd("norm zz")
--   end,
-- })

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
