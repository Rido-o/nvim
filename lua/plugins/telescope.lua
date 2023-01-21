return {
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
    opts = {
        defaults = {
            mappings = {
                i = {
                    ['<Tab>'] = require('telescope.actions').move_selection_previous,
                    ['<S-Tab>'] = require('telescope.actions').move_selection_next,
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

        local map = vim.keymap.set
        local picker = require('telescope.builtin')
        map('n', '<leader>ff', picker.find_files, { desc = 'Find file' })
        map('n', '<leader>fb', picker.buffers, { desc = 'Find buffer' })
        map('n', '<leader>fl', picker.live_grep, { desc = 'Find line' })
        map('n', '<leader>fg', picker.git_files, { desc = 'Find git file' })
        map('n', '<leader>fs', picker.grep_string, { desc = 'Find string' })
        map('n', '<leader>fo', picker.oldfiles, { desc = 'Find recently opened file' })
        map('n', '<leader>fh', picker.command_history, { desc = 'Search command history' })
        map('n', '<leader>fc', picker.colorscheme, { desc = 'List colorschemes' })
        map('n', '<leader>fP', picker.builtin, { desc = 'List all pickers' })
        map('n', '<leader>fd', picker.diagnostics, { desc = 'Show diagnostics' })
        map('n', '<leader>fm', picker.man_pages, { desc = 'Find man page' })
    end,
}
