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
            build = 'gcc', -- was previously make
            cond = vim.fn.executable('gcc') == 1,
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
                        return require('telescope.actions').move_selection_previous(...)
                    end,
                    ['<S-Tab>'] = function(...)
                        return require('telescope.actions').move_selection_next(...)
                    end,
                },
            },
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
    end,
}
