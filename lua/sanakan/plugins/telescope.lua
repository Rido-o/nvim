return {
    -- Requires ripgrep for livegrep picker
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'ahmedkhalf/project.nvim',
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- *Won't work with windows
            build = 'make', -- would preferrably be gcc
            cond = vim.fn.executable('make') == 1,
        },
    },
    cmd = 'Telescope',
    keys = {
        { '<leader>ff', '<CMD>Telescope find_files<CR>', desc = 'Find file' },
        { '<leader>fb', '<CMD>Telescope buffers<CR>', desc = 'Find buffer' },
        { '<leader>fl', '<CMD>Telescope live_grep<CR>', desc = 'Find line' },
        { '<leader>fg', '<CMD>Telescope git_files<CR>', desc = 'Find git file' },
        { '<leader>fs', '<CMD>Telescope grep_string<CR>', desc = 'Find string' },
        { '<leader>fo', '<CMD>Telescope oldfiles<CR>', desc = 'Find recently opened file' },
        { '<leader>fh', '<CMD>Telescope command_history<CR>', desc = 'Search command history' },
        { '<leader>fc', '<CMD>Telescope colorscheme<CR>', desc = 'List colorschemes' },
        { '<leader>fP', '<CMD>Telescope builtin<CR>', desc = 'List all pickers' },
        { '<leader>fd', '<CMD>Telescope diagnostics<CR>', desc = 'Show diagnostics' },
        { '<leader>fm', '<CMD>Telescope man_pages<CR>', desc = 'Find man page' },
        { '<leader>fp', '<CMD>Telescope projects<CR>', desc = 'Find recent project' }, -- TODO need to make it conditional
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    ['<Tab>'] = function(...)
                        return require('telescope.actions').move_selection_next(...)
                    end,
                    ['<S-Tab>'] = function(...)
                        return require('telescope.actions').move_selection_previous(...)
                    end,
                },
            },
            prompt_prefix = require('sanakan.icons').telescope_prefix,
            selection_caret = '  ',
            sorting_strategy = 'ascending',
            layout_config = {
                horizontal = {
                    prompt_position = 'top',
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            path_display = { 'truncate' }, -- ?
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
        },
    },
    config = function(_, opts)
        require('telescope').setup(opts)
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'projects')

        local ts_sp1 = vim.api.nvim_get_hl_by_name('String', true).foreground
        local ts_sp2 = vim.api.nvim_get_hl_by_name('Exception', true).foreground
        local ts_light = vim.api.nvim_get_hl_by_name('ColorColumn', true).background
        local ts_dark = vim.api.nvim_get_hl_by_name('NormalFloat', true).background

        vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = ts_light, bg = ts_light })
        vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = ts_light })
        vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = ts_dark, bg = ts_dark })
        vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = ts_dark })

        vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = ts_sp2, bg = ts_light })
        vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = ts_light, bg = ts_sp1 })
        vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = ts_light, bg = ts_sp2 })
        vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = ts_dark, bg = ts_dark })
        vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = ts_light })
    end,
}
