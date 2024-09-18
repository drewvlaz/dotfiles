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

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("remove_cro"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("c")
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end,
})
