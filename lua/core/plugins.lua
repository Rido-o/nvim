-- Packer Bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim' -- Packer Install path
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap =
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Packer options
packer.init({
    -- Enable floating window for packer
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
    },
})

-- Source plugins config after saving
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile>',
    group = vim.api.nvim_create_augroup('Packer', { clear = true }),
    pattern = 'plugins.lua',
})

-- Function for sourcing config files
local function plugin_config(file)
    require('plugins.' .. file)
end

--------------------------
-- Plugin Management
--------------------------
return packer.startup({
    function(use)
        -- potential plugins {trouble.nvim, nvim-navic, aerial.nvim, neogit, impatient.nvim, alpha-nvim, fidget.nvim, org-mode-clones, clever-f}
        -----------------------
        -- Packer
        -----------------------
        use('wbthomason/packer.nvim')

        ------------
        -- Git
        ------------
        use('tpope/vim-fugitive')
        use({
            'lewis6991/gitsigns.nvim',
            config = plugin_config('gitsigns'),
        })

        ---------------------
        -- Colorschemes
        ---------------------
        use({ 'AlphaTechnolog/pywal.nvim' })
        use({ 'folke/tokyonight.nvim' })
        use({ 'rebelot/kanagawa.nvim' })
        use({ 'franbach/miramare' })

        -------------------------
        -- File Exploration
        -------------------------
        use({
            'nvim-neo-tree/neo-tree.nvim',
            branch = 'v2.x',
            requires = {
                'nvim-lua/plenary.nvim',
                'kyazdani42/nvim-web-devicons',
                'MunifTanjim/nui.nvim',
            },
            config = plugin_config('neo-tree'),
        })

        -----------
        -- UI
        -----------
        use({
            'NvChad/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup()
            end,
        })
        use({
            'feline-nvim/feline.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
                'lewis6991/gitsigns.nvim',
            },
            config = plugin_config('feline'),
        })
        use({
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('indent_blankline').setup({
                    char = '┊',
                })
            end,
        })
        use({
            'folke/which-key.nvim',
            config = plugin_config('which-key'),
        })
        use({
            'noib3/nvim-cokeline',
            requires = {
                'kyazdani42/nvim-web-devicons',
                'famiu/bufdelete.nvim',
            },
            config = plugin_config('cokeline'),
        })
        use({
            'utilyre/barbecue.nvim',
            requires = {
                'smiteshp/nvim-navic',
                'kyazdani42/nvim-web-devicons',
            },
            config = function()
                require('barbecue').setup()
            end,
        })

        -----------------
        -- Filetype
        -----------------
        use({
            'lervag/vimtex', -- Requres latexmk, pdfviewer(mupdf)
            ft = 'tex',
            config = plugin_config('vimtex'),
        })

        ------------------
        -- Utilities
        ------------------
        use('mbbill/undotree')
        use({
            'vimwiki/vimwiki',
            branch = 'dev',
            config = plugin_config('vimwiki'),
        })
        use({
            'akinsho/nvim-toggleterm.lua',
            tag = 'v2.*',
            config = plugin_config('toggleterm'),
        })
        use({
            'jose-elias-alvarez/null-ls.nvim',
            config = plugin_config('null-ls'),
        })
        use({
            -- Requires ripgrep for livegrep picker
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    -- Won't work with windows
                    run = 'make',
                    cond = vim.fn.executable('make') == 1,
                },
            },
            config = plugin_config('telescope'),
        })
        use({
            'ahmedkhalf/project.nvim',
            config = plugin_config('project'),
            requires = 'nvim-telescope/telescope.nvim',
        })
        use({
            'ggandor/leap.nvim',
            config = function()
                require('leap').set_default_keymaps()
            end,
        })

        ------------
        -- lSP
        ------------
        -- Check mason requirements
        use({
            'williamboman/mason.nvim',
            requires = {
                { 'williamboman/mason-lspconfig.nvim' },
                { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
            },
            config = plugin_config('mason'),
        })
        use({
            'neovim/nvim-lspconfig',
            config = plugin_config('lspconfig'),
        })
        use({
            'hrsh7th/nvim-cmp',
            requires = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-cmdline' },
                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'rafamadriz/friendly-snippets' },
            },
            config = {
                plugin_config('cmp'),
                -- Enable friendly snippets
                require('luasnip.loaders.from_vscode').lazy_load(),
            },
        })
        use({
            'glepnir/lspsaga.nvim',
            config = plugin_config('lspsaga'),
        })
        use({
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = plugin_config('treesitter'),
        })

        ---------------
        -- Editor
        ---------------
        use({
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
        })
        use({
            'windwp/nvim-autopairs',
            config = plugin_config('autopairs'),
        })
        use({
            'kylechui/nvim-surround',
            config = plugin_config('surround'),
        })
        use('tpope/vim-repeat')

        -- Run bootstrap if packer isnt' installed
        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if Packer_bootstrap then
            require('packer').sync()
        end
    end,
})
