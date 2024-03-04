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

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("special_formatting"),
  pattern = "*",
  callback = function()
    vim.cmd("highlight String gui=italic cterm=italic")
    vim.cmd("highlight Normal ctermbg=none guibg=none")
    vim.cmd("highlight NormalNC ctermbg=none guibg=none")
    vim.cmd("highlight NonText ctermbg=none guibg=none")
    vim.cmd("highlight SignColumn guibg=none ctermbg=none")
    vim.cmd("highlight EndOfBuffer guibg=none ctermbg=none")
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup("center_on_insert"),
  pattern = "*",
  callback = function()
    vim.cmd("norm zz")
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("remove_cro"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("c")
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end,
})
