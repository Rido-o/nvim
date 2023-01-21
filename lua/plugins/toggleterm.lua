return {
    'akinsho/toggleterm.nvim',
    keys = '<c-\\>',
    opts = {
        size = 15,
        open_mapping = [[<c-\>]], -- Same as <c-4>
        shading_factor = '0', -- default is -30, makes background darker
        start_in_insert = false,
        close_on_exit = false, -- close the terminal window when the process exits
    },
    config = function(_, opts)
        require('toggleterm').setup(opts)

        -- Terminal Mappings
        function _G.set_terminal_keymaps()
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
        end

        -- Make mappings only apply to toggleterm
        vim.api.nvim_create_autocmd('TermOpen', {
            group = vim.api.nvim_create_augroup('SetTermBinds', { clear = true }),
            pattern = 'term://*toggleterm#*',
            command = 'lua set_terminal_keymaps()',
        })
    end,
}
