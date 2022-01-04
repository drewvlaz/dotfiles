-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- UTILITIES
    -- use 'scrooloose/NERDTree'                          -- file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'sheerun/vim-polyglot'                            -- better syntax highlighting
    use {'neoclide/coc.nvim', branch = 'release'}         -- intellisense
    use 'airblade/vim-gitgutter'                          -- git info in side bar
    use {'lervag/vimtex', ft = {"tex"} }                                  -- latex tools
    use 'jiangmiao/auto-pairs'                            -- auto close pairs
    use 'luochen1990/rainbow'                             -- colorize pairs
    use 'unblevable/quick-scope'                          -- enhanced f, F, t, T
    use 'justinmk/vim-sneak'                              -- two letter jump to
    use 'nvim-lua/popup.nvim'                             -- better fzf
    use 'nvim-lua/plenary.nvim'                           -- better fzf
    use 'nvim-telescope/telescope.nvim'                   -- better fzf
    use 'ap/vim-css-color'                                -- highlight hex colors
    use 'junegunn/goyo.vim'                               -- zen mode
    use 'junegunn/limelight.vim'                          -- light up only focused text
    use 'tpope/vim-commentary'                            -- better commenting
    -- use 'mhinz/vim-startify'                              -- add start screen to vim
    use 'glepnir/dashboard-nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'
    
    --AESTHETIC
    -- themes
    use 'morhetz/gruvbox'
    use 'joshdick/onedark.vim'
    use 'haishanh/night-owl.vim'
    use 'romainl/flattened'
    use 'whatyouhide/vim-gotham'
    use {'embark-theme/vim', as = 'embark' }
    use 'sainnhe/everforest'
    use 'sainnhe/sonokai'
    -- use 'folke/tokyonight.nvim'
    use 'ghifarit53/tokyonight-vim'
    -- line
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'ryanoasis/vim-devicons'
    use {
        'akinsho/bufferline.nvim', 
        requires = 'kyazdani42/nvim-web-devicons'
    }
end)
