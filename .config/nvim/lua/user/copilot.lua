vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.g.copilot_file_types = {
  ['*'] = false,
  ['javascript'] = true,
  ['typescript'] = true,
  ['lua'] = true,
  ['rust'] = true,
  ['c'] = true,
  ['c#'] = true,
  ['c++'] = true,
  ['go'] = true,
  ['python'] = true,
}

vim.cmd[[highlight CopilotSuggestion guifg=#ffb996 ctermfg=8]]     
