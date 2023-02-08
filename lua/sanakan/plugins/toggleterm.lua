return {
    'akinsho/toggleterm.nvim',
    keys = {
        { '<c-\\>' },
        { '<leader>`', desc = 'Toggle lazygit' },
    },
    cmd = 'ToggleTerm',
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
            vim.keymap.set('n', '<esc>', '<CMD>q<CR>', { buffer = 0 })
        end

        -- Make mappings only apply to toggleterm
        vim.api.nvim_create_autocmd('TermOpen', {
            group = vim.api.nvim_create_augroup('SetTermBinds', { clear = true }),
            pattern = 'term://*toggleterm#*',
            command = 'lua set_terminal_keymaps()',
        })

        -- Lazygit
        if vim.fn.executable('lazygit') then
            local terminal = require('toggleterm.terminal').Terminal
            local lazygit = terminal:new({
                cmd = 'lazygit',
                hidden = true,
                direction = 'float',
                on_open = function(_)
                    vim.cmd('startinsert!')
                end,
            })

            function Lazygit_toggle()
                lazygit:toggle()
            end

            vim.api.nvim_set_keymap('n', '<leader>`', '<CMD>lua Lazygit_toggle()<CR>', { desc = 'Toggle lazygit' })
        end
    end,
}
