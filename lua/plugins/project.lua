local status_ok, project = pcall(require, 'project_nvim')
if not status_ok then
    return
end

project.setup({
    detection_methods = { 'pattern', 'lsp' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '>.config' },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    datapath = vim.fn.stdpath('data'),
})

pcall(require('telescope').load_extension, 'projects')
vim.keymap.set('n', '<leader>fp', '<CMD>Telescope projects<CR>', { desc = 'Find recent project' })
