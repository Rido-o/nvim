--------------
-- Latex
--------------
--autocmd filetype python <silent> <F5> :!latexmk -pdfxe --interaction=batchmod
--autocmd filetype latex <silent> <F5> :AsyncRunlatexmk -pdflatex='xelatex %O %S' -pdf -f --interaction=batchmod "%"
--autocmd FileType tex nnoremap <silent> <buffer> <F5> :w<CR>:AsyncRun -mode=term -pos=bottom -rows=10 latexmk -pdflatex='xelatex \%O \%S' -pdf "--interaction=batchmode" -f "%" <CR><C-\><C-N>
--autocmd FileType tex nnoremap <silent> <buffer> <F5> :w<CR>:AsyncRun -mode=term -pos=bottom -rows=10 latexmk -pdflatex='xelatex \%O \%S' -pdf -f "%" <CR><C-\><C-N>
--autocmd FileType tex nnoremap <silent> <buffer> <F5> :w<CR>:split<CR>:resize 10<CR>:ter clear;latexmk -pdflatex='xelatex \%O \%S' -pdf --interaction=batchmode -f "%" <CR><C-\><C-N>

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', opts, { buffer = 0 })
    vim.keymap.set(mode, '<localleader>' .. lhs, rhs, opts)
end

map('n', 'i', '<plug>(vimtex-info)', { desc = 'Latex info' })
map('n', 'I', '<plug>(vimtex-info-full)', { desc = 'Latex full info' })
map('n', 't', '<plug>(vimtex-toc-open)', { desc = 'Latex open toc' })
map('n', 'T', '<plug>(vimtex-toc-toggle)', { desc = 'Latex toggle toc' })
map('n', 'q', '<plug>(vimtex-log)', { desc = 'Latex log' })
map('n', 'v', '<plug>(vimtex-view)', { desc = 'Latex view' })
map('n', 'r', '<plug>(vimtex-reverse-search)', { desc = 'Latex reverse search' })
map('n', 'l', '<plug>(vimtex-compile)', { desc = 'Latex compile' })
map('n', 'L', '<plug>(vimtex-compile-selected)', { desc = 'Latex compile selected' })
map('n', 'k', '<plug>(vimtex-stop)', { desc = 'Latex stop' })
map('n', 'K', '<plug>(vimtex-stop-all)', { desc = 'Latex stop all' })
map('n', 'e', '<plug>(vimtex-errors)', { desc = 'Latex errors' })
map('n', 'o', '<plug>(vimtex-compile-output)', { desc = 'Latex compile output' })
map('n', 'g', '<plug>(vimtex-status)', { desc = 'Latex status' })
map('n', 'G', '<plug>(vimtex-status-all)', { desc = 'Latex status all' })
map('n', 'c', '<plug>(vimtex-clean)', { desc = 'Latex clean' })
map('n', 'C', '<plug>(vimtex-clean-all)', { desc = 'Latex clean all' })
map('n', 'm', '<plug>(vimtex-imaps-list)', { desc = 'Latex imaps list' })
map('n', 'x', '<plug>(vimtex-reload)', { desc = 'Latex reload' })
map('n', 'X', '<plug>(vimtex-reload-state)', { desc = 'Latex reload state' })
map('n', 's', '<plug>(vimtex-toggle-main)', { desc = 'Latex toggle main' })
