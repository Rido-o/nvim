return {
    -- potential plugins { trouble.nvim, nvim-navic/barbecue, aerial.nvim, neogit, alpha-nvim, fidget.nvim, neorg/orgmode, lsp-zero, heirline.nvim, diffview.nvim, nvim-spectre, searchbox.nvim, statuscol.nvim }

    ---- UI ----
    {
        'NvChad/nvim-colorizer.lua',
        config = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            char = '┊',
        },
    },
    {
        'nvim-neorg/neorg',
        build = ':Neorg sync-parsers',
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        ft = 'norg',
        cmd = 'Neorg',
        opts = {
            load = {
                ['core.defaults'] = {},
                ['core.norg.concealer'] = {},
                ['core.norg.dirman'] = {
                    config = {
                        workspaces = {
                            notes = '~/notes',
                            wiki = '~/.cfg/wiki',
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            require('neorg').setup(opts)
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('NeorgSettings', { clear = true }),
                pattern = 'norg',
                callback = function()
                    vim.o.conceallevel = 2
                    vim.o.foldlevel = 7
                end,
            })
        end,
    },

    ---- Utilities ----
    {
        'mbbill/undotree',
        keys = {
            { '<leader>U', '<CMD>UndotreeToggle<CR>', mode = 'n', desc = 'Open undo tree' },
        },
    },
    {
        'ahmedkhalf/project.nvim',
        opts = {
            detection_methods = { 'pattern', 'lsp' },
            patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '>.config' },
        },
        config = function(_, opts)
            require('project_nvim').setup(opts)
        end,
    },
    {
        'ggandor/leap.nvim',
        dependencies = { -- can repeat.vim for . functionality
            'ggandor/flit.nvim', -- enhanced f/t motions
            config = true,
        },
        event = 'InsertEnter',
        config = function()
            require('leap').set_default_keymaps()
        end,
    },

    ---- lSP ----
    {
        'nvim-treesitter/nvim-treesitter',
        cond = vim.fn.executable('gcc') == 1,
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'lua', 'python', 'nix' },
            highlight = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    scope_incremental = '<S-CR>',
                    node_decremental = '<BS>',
                },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },

    ---- Editor ----
    {
        'numToStr/Comment.nvim',
        keys = {
            { '<leader>c', '<plug>(comment_toggle_linewise_current)', mode = 'n', desc = 'Toggle comment' },
            { '<leader>c', '<plug>(comment_toggle_linewise_visual)', mode = 'x', desc = 'Toggle comment' },
        },
        config = true,
    },
}
