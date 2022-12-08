local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', opts, { buffer = 0 })
    vim.keymap.set(mode, '<localleader>' .. lhs, rhs, opts)
end

map('n', 'r', '<CMD>1TermExec cmd=\'python "%"\' go_back=0<CR>', { desc = 'Run code' })
map('n', 'b', '<CMD>1TermExec cmd=\'hyperfine --warmup 10 "python %"\' go_back=0<CR>', { desc = 'Benchmark code' })
map('n', 'i', '<CMD>2TermExec cmd="python" go_back=0<CR>', { desc = 'Open repl' })
