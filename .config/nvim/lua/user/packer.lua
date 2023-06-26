local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save this file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

vim.cmd.packadd('packer.nvim')

-- Install your plugins here
return packer.startup(function(use)
    -- Misc
    use "wbthomason/packer.nvim" -- Have packer manage itself
    -- use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    -- use "akinsho/bufferline.nvim"
    -- use "akinsho/toggleterm.nvim"
    use "nvim-lualine/lualine.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim" -- lazy loading
    use "lukas-reineke/indent-blankline.nvim" -- Show indent characters
    use "goolord/alpha-nvim" -- Startup menu
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use "folke/which-key.nvim"
    -- use "junegunn/goyo.vim"
    -- use "gen740/SmoothCursor.nvim"

    -- Motion
    use 'unblevable/quick-scope' -- enhanced f, F, t, T
    use 'ggandor/leap.nvim'

    -- Colorschemes
    use "lunarvim/onedarker.nvim"
    use "folke/tokyonight.nvim"
    use "sainnhe/sonokai"
    use "Mofiqul/dracula.nvim"
    use "sainnhe/everforest"
    use "catppuccin/nvim"
    -- use "morhetz/gruvbox"
    -- use "dracula/vim"
    use "norcalli/nvim-colorizer.lua"

    -- LSP/Completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-cmdline'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    } 
    use "github/copilot.vim"
    use "folke/trouble.nvim" -- pretty list for code diagnostics

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "ThePrimeagen/harpoon"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        -- commit = "d37fc85a4060352bcd4d8cbed0907cba442deb90"
        requires = {
            {'nvim-treesitter/nvim-treesitter-context'},
        }
    }

    -- Git
    use "lewis6991/gitsigns.nvim"
    use "tpope/vim-fugitive"
    use "APZelos/blamer.nvim"

    -- Commenting
    use 'tpope/vim-commentary'

    -- Languages
    use 'simrat39/rust-tools.nvim'

    -- Documents
    use {
        'lervag/vimtex',
        ft = {"tex"},
    }
    use { 
        "iamcco/markdown-preview.nvim", 
        run = "cd app && npm install", 
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, 
        ft = { "markdown" }, 
    }
    -- use "xuhdev/vim-latex-live-preview"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
