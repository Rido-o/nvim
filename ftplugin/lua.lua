local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', opts, { buffer = 0 })
    vim.keymap.set(mode, '<localleader>' .. lhs, rhs, opts)
end

map('n', 'a', function()
    print('hello')
end, { desc = 'Print hello' })
