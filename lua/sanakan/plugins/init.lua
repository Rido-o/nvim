return {
    -- potential plugins { trouble.nvim, nvim-navic/barbecue, aerial.nvim, neogit, alpha-nvim, fidget.nvim, lsp-zero, heirline.nvim, diffview.nvim, nvim-spectre, searchbox.nvim, statuscol.nvim, substitute.nvim, vim-wordmotion, reticle.nvim, nvim-ufo }

    ---- UI ----
    {
        'NvChad/nvim-colorizer.lua',
        config = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            indent = { char = '┊' },
        },
    },
    {
        'nvim-neorg/neorg-telescope',
        dependencies = {
            'nvim-neorg/neorg',
            'nvim-telescope/telescope.nvim',
        },
        -- cmd = 'Telescope neorg', -- TODO make this work
        keys = {
            { '<leader>fn', '<CMD>Telescope neorg switch_workspace<CR>', desc = 'Switch neorg workspace' },
        },
    },
    {
        'nvim-neorg/neorg', -- TODO Add local leader bindings for norg files
        build = ':Neorg sync-parsers',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        ft = 'norg',
        cmd = 'Neorg',
        opts = {
            load = {
                ['core.defaults'] = {},
                ['core.concealer'] = {},
                ['core.dirman'] = {
                    config = {
                        workspaces = {
                            notes = '~/notes',
                            wiki = '~/.cfg/wiki',
                        },
                    },
                },
                ['core.completion'] = {
                    config = {
                        engine = 'nvim-cmp',
                    },
                },
                ['core.integrations.telescope'] = {},
                ['core.keybinds'] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.map('norg', 'n', '<BS>', '<C-^>') -- :e#
                        end,
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
            if vim.g.os == 'Windows' then -- TODO check if necessary
                table.remove(opts.patterns, 8)
            end
            require('project_nvim').setup(opts)
        end,
    },
    {
        'ggandor/leap.nvim',
        dependencies = {
            -- can repeat.vim for . functionality
            'ggandor/flit.nvim', -- enhanced f/t motions
            config = true,
            keys = {
                { 'f', mode = { 'n', 'x' } },
                { 'F', mode = { 'n', 'x' } },
                { 't', mode = { 'n', 'x' } },
                { 'T', mode = { 'n', 'x' } },
            },
        },
        keys = {
            {
                's',
                function()
                    require('leap').leap({ target_windows = { vim.fn.win_getid() } })
                end,
                mode = { 'n', 'x' },
            }, -- Omnidirectional search
        },
        config = function()
            require('leap').set_default_keymaps() -- might not be needed with keys set
        end,
    },
    {
        'famiu/bufdelete.nvim',
        cmd = 'Bdelete',
        keys = {
            { '<leader>bq', '<CMD>Bdelete<CR>', desc = 'Buffer delete' },
        },
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
    {
        'kylechui/nvim-surround',
        config = true,
    },
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        opts = {
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'black' },
                nix = { 'nixpkgs_fmt' },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
    },
    {
        'mfussenegger/nvim-lint',
        config = function(_, _)
            require('lint').linters_by_ft = {
                nix = { 'statix' },
            }
            vim.api.nvim_create_autocmd({ 'TextChanged', 'BufEnter', 'BufWritePost' }, {
                callback = function()
                    require('lint').try_lint()
                end,
            })
        end,
    },
}
