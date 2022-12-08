local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup({
    size = 15,
    open_mapping = [[<c-\>]], -- Same as <c-4>
    shading_factor = '1',
    start_in_insert = false,
    close_on_exit = false, -- close the terminal window when the process exits
})

-- Terminal Mappings
function _G.set_terminal_keymaps()
    local map = vim.keymap.set
    local opts = { noremap = true, buffer = 0 }
    map('t', '<esc>', [[<C-\><C-n>]], opts)
end

-- Make mappings only apply to toggleterm
vim.api.nvim_create_autocmd( 'TermOpen', {
    group = vim.api.nvim_create_augroup('SetTermBinds', { clear = true }),
    pattern = 'term://*toggleterm#*',
    command = 'lua set_terminal_keymaps()'
})
