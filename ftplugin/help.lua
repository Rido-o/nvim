-- Make help files open in a vertical split by default
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = vim.api.nvim_create_augroup('OpenHelpVertical', { clear = true }),
    buffer = 0,
    command = 'wincmd L',
})
