-- Based off of Eviline listed on lualine Github

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local lualine = require('lualine')

-- Color table for highlights
local colors = {
  -- everforest -- 
  -- black = '#4b565c',
  -- blue = '#7fbbb3',
  -- bg = '#2b3339',
  -- cyan = '#83c092',
  -- darkblue = '#7fbbb3',
  -- green = '#a7c080',
  -- fg = '#d3c6aa',
  -- magenta = '#d699b6',
  -- orange = '#e67e80',
  -- red = '#e67e80',
  -- violet = '#d699b6',
  -- yellow = '#dbbc7f',
  -- everforest -- 

  -- sonokai -- 
  black    = '#4b565c',
  blue     = '#51afef',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  fg       = '#bbc2cf',
  magenta  = '#c678dd',
  orange   = '#ffb86c',
  red      = '#ec5f67',
  violet   = '#b39df3',
  yellow   = '#ffe76e',
  -- sonokai -- 
}

-- Change color according to vim mode
local mode_color = {
  n = colors.red,
  i = colors.green,
  v = colors.magenta,
  [''] = colors.magenta,
  V = colors.magenta,
  c = colors.blue,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [''] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.red,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    -- theme = 'sonokai',
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end


-- Add components to right sections

ins_left {
  -- mode component
  function()
    -- other icons:▊,,,,,,,,,ﱦ,異,,
    return '▊ '
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 0, right = 1 },
}

ins_left {
  'filename',
  path = 1,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.fg, gui = 'bold' },
  symbols = {
    modified = '●',      -- Text to show when the file is modified.
    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]',     -- Text to show for newly created file before first write
  },
}


ins_left {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.blue },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}


-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}


-- Add components to right sections

ins_right {
  'filetype',
  cond = conditions.hide_in_width,
}

-- ins_right {
--   'o:encoding', -- option component same as &encoding in viml
--   fmt = string.upper, -- I'm not sure why it's upper case either ;)
--   cond = conditions.hide_in_width,
--   color = { fg = colors.fg, gui = 'bold' },
-- }


ins_right {
  -- Lsp server name .
  function()
    local msg = '[No Active Lsp]'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    local clients_str = ""
    local seen = {}
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      -- there can be multiple Lsp's and sometimes they are duplicated
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and not seen[client.name] then
        clients_str = clients_str .. ', ' .. client.name
        seen[client.name] = true
      end
    end
    if clients_str == nil  or clients_str == '' then
      return msg
    else
      return '[' .. string.sub(clients_str, 3) .. ']'
    end
  end,
  icon = '',
  color = { fg = colors.yellow, gui = 'bold' },
  cond = conditions.hide_in_width,
}

ins_right { 'location' }

ins_right {
  'progress',
  color = { fg = colors.fg, gui = 'bold' },
  padding = { right = 0 },
}

ins_right {
  function()
    return "/%L"
  end,
  color = { fg = colors.fg, gui = 'bold' },
  padding = { left = 0 },
}

ins_right {
  function()
    -- return '▊'
    return ''
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

