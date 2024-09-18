-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.fn.exists("g:vscode") ~= 0 then
  return {}
end

require("config.lazy")
