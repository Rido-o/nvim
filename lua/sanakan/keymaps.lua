local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', opts, { noremap = true, silent = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Escape to clear highlighting
map('n', '<ESC>', '<ESC>:noh<CR>', { desc = 'Clear highlighting' })
map('n', '<BS>', '<C-o>', { desc = 'Clear highlighting' })

-- Do action without yanking into "+ register
map({ 'n', 'v' }, 'c', '"_c', { desc = 'Change' })
map({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete char' })

-- Single key leader mappings
map('n', '<leader>s', '<CMD>wincmd s<CR>', { desc = 'Horizontal split' })
map('n', '<leader>v', '<CMD>wincmd v<CR>', { desc = 'Vertical split' })
map('n', '<leader>h', '<CMD>wincmd h<CR>', { desc = 'Move left' })
map('n', '<leader>j', '<CMD>wincmd j<CR>', { desc = 'Move down' })
map('n', '<leader>k', '<CMD>wincmd k<CR>', { desc = 'Move up' })
map('n', '<leader>l', '<CMD>wincmd l<CR>', { desc = 'Move right' })
map('n', '<leader>w', '<CMD>w<CR>', { desc = 'Write' })
map('n', '<leader>q', '<CMD>q<CR>', { desc = 'Quit' })

-- Buffer management mappings
map('n', '<leader>bQ', '<CMD>w|%bd|e#|bd#<CR>', { desc = 'Close all except current' })

-- Mouse keybinds
map('n', '<ScrollWheelUp>', 'k', { desc = 'Scroll up' })
map('n', '<ScrollWheelDown>', 'j', { desc = 'Scroll up' })

-- Tab/Shift+tab to indent/dedent
map('v', '<Tab>', '>gv', { desc = 'Indent line' })
map('n', '<Tab>', 'v><C-\\><C-N>', { desc = 'Indent Selection' })
map('v', '<S-Tab>', '<gv', { desc = 'Unindent line' })
map('n', '<S-Tab>', 'v<<C-\\><C-N>', { desc = 'Unindent Selection' })
