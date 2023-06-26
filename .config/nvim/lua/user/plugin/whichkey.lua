local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in normal or <c-r> in insert mode
    spelling = {
      enabled = true, -- enabling this will show whichkey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in neovim
    -- no actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<CR>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local opts_visual = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- local opts_visual = opts
-- opts_visual[mode] = "v"

local mappings = {
  ["/"] = { "<cmd>Commentary<CR>", "Comment" },
  -- a = { "<cmd>Alpha<CR>", "Alpha" },
  b = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    "Buffers",
  },
  c = { "<cmd>bd!<CR>", "Close Buffer" },
  e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  w = { "<cmd>w!<CR>", "Save" },
  -- q = { "<cmd>q<CR>", "Quit" },
  Q = { "<cmd>q!<CR>", "Force Quit" },
  H = { "<cmd>nohlsearch<CR>", "No Highlight" },
     h = {
       name = "Harpoon",
       A = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add file" },
       v = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "View marks" },
       n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Next file" },
       p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Prev file" },
       a = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Goto file 1" },
       b = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Goto file 2" },
       c = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Goto file 3" },
       d = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Goto file 4" },
       e = { "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", "Goto file 5" },
       f = { "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", "Goto file 6" },
       g = { "<cmd>lua require('harpoon.ui').nav_file(7)<CR>", "Goto file 7" },
       h = { "<cmd>lua require('harpoon.ui').nav_file(8)<CR>", "Goto file 8" },
     },
  f = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    "Find files",
  },
  F = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },
  P = { "<cmd>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },

  d = {
    name = "Document",
    -- c = { "<cmd>LLPStartPreview<CR>", "Compile"},
    c = { "<cmd>VimtexCompile<CR>", "Compile"},
    f = { "<cmd>LspZeroFormat<CR>", "Format"},
    s = { "<cmd>set spell! spell?<CR>", "Toggle spelling"},
    S = { "z=", "Spell suggestions"},
    m = { "ciW$$<ESC>P", "Format math"},
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    s = { "<cmd>PackerSync<CR>", "Sync" },
    S = { "<cmd>PackerStatus<CR>", "Status" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    B = { "<cmd>G blame<CR>", "Blame file" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<CR>",
      "Diff",
    },
  },

  G = { "<cmd>Goyo<CR>", "Goyo toggle" },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    -- d = {
    --   "<cmd>Telescope lsp_document_diagnostics<CR>",
    --   "Document Diagnostics",
    -- },
    -- w = {
    --   "<cmd>Telescope lsp_workspace_diagnostics<CR>",
    --   "Workspace Diagnostics",
    -- },
    d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Diagnostics" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Search in buffer" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
    -- c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    c = {
          "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<CR>",
          "Colorscheme with Preview",
    },
    h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
    f = { "<cmd>Telescope find_files<CR>", "Find File" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
  },

  t = {
    name = "Tag",
    g = { "<C-]>", "Goto" },
    n = { "<cmd>tn<CR>", "Next" },
    p = { "<cmd>tp<CR>", "Prev" },
    v = { "<C-w><C-]>", "View" },
  },
}

local mappings_visual = {
  ["/"] = { ":'<,'>Commentary<CR>", "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(mappings_visual, opts_visual)

