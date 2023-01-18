-----------------
-- Settings
-----------------
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk = {
    ['build_dir'] = '',
    ['callback'] = 1,
    ['continuous'] = 1,
    ['executable'] = 'latexmk',
    ['hooks'] = { '' },
    ['options'] = {
        '-pdf',
        '-xelatex',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

-- Set pdf viewer
if vim.g.os == 'Windows' then
    vim.g.vimtex_view_general_viewer = 'SumatraPDF'
elseif vim.g.os == 'Linux' then
    vim.g.vimtex_view_general_viewer = 'MuPDF'
end
