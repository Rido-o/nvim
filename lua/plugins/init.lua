return {
    -- potential plugins {trouble.nvim, nvim-navic, aerial.nvim, neogit, impatient.nvim, alpha-nvim, fidget.nvim, org-mode-clones, clever-f}

    ------------
    -- Git
    ------------
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('config.gitsigns')
        end,
    },

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
            require('config.neo-tree')
        end,
    },

    -----------
    -- UI
    -----------
    {
        'NvChad/nvim-colorizer.lua',
        config = true,
    },
    {
        'feline-nvim/feline.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            require('config.feline')
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
            require('config.which-key')
        end,
    },
    {
        'noib3/nvim-cokeline',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'famiu/bufdelete.nvim',
        },
        config = function()
            require('config.cokeline')
        end,
        event = 'ColorScheme',
    },

    -----------------
    -- Filetype
    -----------------
    {
        'lervag/vimtex', -- Requres latexmk, pdfviewer(mupdf)
        ft = 'tex',
        config = function()
            require('config.vimtex')
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
            require('config.vimwiki')
        end,
    },
    {
        'akinsho/nvim-toggleterm.lua',
        tag = 'v2.*',
        config = function()
            require('config.toggleterm')
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('config.null-ls')
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
            require('config.telescope')
        end,
    },
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup({
                detection_methods = { 'pattern', 'lsp' },
                patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '>.config' },
            })

            local status_telescope_ok, telescope = pcall(require, 'telescope')
            if status_telescope_ok then
                telescope.load_extension('projects')
                vim.keymap.set('n', '<leader>fp', '<CMD>Telescope projects<CR>', { desc = 'Find recent project' })
            end
        end,
        dependencies = 'nvim-telescope/telescope.nvim',
    },
    {
        'ggandor/leap.nvim',
        dependencies = {
            'ggandor/flit.nvim', -- enhanced f/t motions
            config = true,
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
            require('config.mason')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('config.lspconfig')
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
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            require('config.cmp')
            require('luasnip.loaders.from_vscode').lazy_load() -- TODO fix so it doesn't break initial install
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'lua', 'python', 'nix' },
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        scope_incremental = '<S-CR>',
                        node_decremental = '<BS>',
                    },
                },
            })
        end,
        cond = vim.fn.executable('gcc') == 1,
    },

    ---------------
    -- Editor
    ---------------
    {
        'numToStr/Comment.nvim',
        config = true,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('config.autopairs')
        end,
    },
    {
        'kylechui/nvim-surround',
        config = function()
            require('config.surround')
        end,
    },
    'tpope/vim-repeat',
}
