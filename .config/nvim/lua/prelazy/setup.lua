-- Q: Why is this file needed?
-- A: For some reason, when launching nvim without any args,
--    the colorscheme autocommand is not run which messes up
--    the visuals. It's put here and run before any lazyvim stuff.

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

  -- local attribute_highlight = vim.api.nvim_get_hl(0, { name = "Special" })
  vim.api.nvim_set_hl(0, "@variable.parameter.python", { bold = true })

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
  group = vim.api.nvim_create_augroup("custom_" .. "color_special_formatting", { clear = true }),
  pattern = "*",
  callback = custom_hi_groups,
})

return {}
