-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.fn.exists('g:vscode') == 0 then
    require("config.lazy")
end
