-- Lazy Bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- -- Source plugins config after saving
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile>',
    group = vim.api.nvim_create_augroup('lazy', { clear = true }),
    pattern = 'plugins.lua',
})

--------------------------
-- Plugin Management
--------------------------
require('lazy').setup({
    -- potential plugins {trouble.nvim, nvim-navic, aerial.nvim, neogit, impatient.nvim, alpha-nvim, fidget.nvim, org-mode-clones, clever-f}

    ------------
    -- Git
    ------------
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('plugins.gitsigns')
        end,
    },

    ---------------------
    -- Colorschemes
    ---------------------
    'AlphaTechnolog/pywal.nvim',
    'folke/tokyonight.nvim',
    'rebelot/kanagawa.nvim',
    'franbach/miramare',

    -------------------------
    -- File Exploration
    -------------------------
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require('plugins.neo-tree')
        end,
    },

    -----------
    -- UI
    -----------
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
    {
        'feline-nvim/feline.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            require('plugins.feline')
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                char = '┊',
            })
        end,
    },
    {
        'folke/which-key.nvim',
        config = function()
            require('plugins.which-key')
        end,
    },
    {
        'noib3/nvim-cokeline',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'famiu/bufdelete.nvim',
        },
        config = function()
            require('plugins.cokeline')
        end,
    },
    {
        'utilyre/barbecue.nvim',
        dependencies = {
            'smiteshp/nvim-navic',
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require('plugins.barbecue')
        end,
    },

    -----------------
    -- Filetype
    -----------------
    {
        'lervag/vimtex', -- Requres latexmk, pdfviewer(mupdf)
        ft = 'tex',
        config = function()
            require('plugins.vimtex')
        end,
    },

    ------------------
    -- Utilities
    ------------------
    'mbbill/undotree',
    {
        'vimwiki/vimwiki',
        branch = 'dev',
        config = function()
            require('plugins.vimwiki')
        end,
    },
    {
        'akinsho/nvim-toggleterm.lua',
        tag = 'v2.*',
        config = function()
            require('plugins.toggleterm')
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('plugins.null-ls')
        end,
    },
    {
        -- Requires ripgrep for livegrep picker
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- Won't work with windows
                build = 'make',
                cond = vim.fn.executable('make') == 1,
            },
        },
        config = function()
            require('plugins.telescope')
        end,
    },
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('plugins.project')
        end,
        dependencies = 'nvim-telescope/telescope.nvim',
    },
    {
        'ggandor/leap.nvim',
        dependencies = {
            'ggandor/flit.nvim',
            config = function()
                require('flit').setup()
            end,
        },
        config = function()
            require('leap').set_default_keymaps()
        end,
    },

    ------------
    -- lSP
    ------------
    -- Check mason requirements
    {
        'williamboman/mason.nvim',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
        },
        config = function()
            require('plugins.mason')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.lspconfig')
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            -- Snippets
            {
                'L3MON4D3/LuaSnip',
                config = {
                    function()
                        -- Enable friendly snippets
                        require('luasnip.loaders.from_vscode').lazy_load() -- TODO fix so it doesn't break initial install
                    end,
                },
            },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = {
            function()
                require('plugins.cmp')
            end,
        },
    },
    {
        'glepnir/lspsaga.nvim',
        config = function()
            require('plugins.lspsaga')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('plugins.treesitter')
        end,
        cond = vim.fn.executable('gcc') == 1,
    },

    ---------------
    -- Editor
    ---------------
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('plugins.autopairs')
        end,
    },
    {
        'kylechui/nvim-surround',
        config = function()
            require('plugins.surround')
        end,
    },
    'tpope/vim-repeat',
})
