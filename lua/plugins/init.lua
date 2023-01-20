return {
    -- potential plugins { trouble.nvim, nvim-navic/barbecue, aerial.nvim, neogit, alpha-nvim, fidget.nvim, neorg/orgmode, lsp-zero, heirline.nvim, diffview.nvim }

    ---- UI ----
    {
        'NvChad/nvim-colorizer.lua',
        config = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = {
            char = '┊',
        },
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
        dependencies = 'nvim-telescope/telescope.nvim',
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
    },
    {
        'ggandor/leap.nvim',
        dependencies = { -- can repeat.vim for . functionality
            'ggandor/flit.nvim', -- enhanced f/t motions
            config = true,
        },
        config = function()
            require('leap').set_default_keymaps()
        end,
    },

    ---- lSP ----
    {
        'nvim-treesitter/nvim-treesitter',
        cond = vim.fn.executable('gcc') == 1,
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
