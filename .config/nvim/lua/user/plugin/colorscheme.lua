local colorscheme = "sonokai"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found")
  vim.cmd("colorscheme default")
  vim.cmd("set background=dark")
  return
end
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.everforest_background = 'soft'
vim.g.everforest_better_performance = 1
