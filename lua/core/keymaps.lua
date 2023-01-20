local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', opts, { noremap = true, silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

--------------
-- Basic
--------------
-- Escape to clear highlighting
map('n', '<ESC>', '<ESC>:noh<CR>', { desc = 'Clear highlighting' })

-- Do action without yanking into "+ register
map({ 'n', 'v' }, 'c', '"_c', { desc = 'Change' })
map({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete char' })

----------------
-- Replace
----------------
-- add number support and dot support for rr -- Figure out how to make it work with whichkey
function _G.Replace_operator(motion)
    if motion == nil then
        vim.o.operatorfunc = 'v:lua.Replace_operator'
        return 'g@'
    end
    local start = vim.api.nvim_buf_get_mark(0, '[')
    local finish = vim.api.nvim_buf_get_mark(0, ']')
    local replacement = vim.split(vim.fn.getreg('+'):gsub('%\n$', ''), '\n', false)
    if motion == 'char' then
        vim.api.nvim_buf_set_text(0, start[1] - 1, start[2], finish[1] - 1, finish[2] + 1, replacement)
    elseif motion == 'line' then
        vim.api.nvim_buf_set_lines(0, start[1] - 1, finish[1], true, replacement)
    elseif motion == 'block' then
        for i = start[1] - 1, finish[1] - 1 do
            vim.api.nvim_buf_set_text(0, i, start[2], i, finish[2] + 1, replacement)
        end
    elseif motion == 'r' then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(0, row - 1, row, true, replacement)
    end
end

map({ 'n', 'v' }, 'r', _G.Replace_operator, { desc = 'Replace', expr = true })
map('n', 'rr', '<ESC><CMD>lua _G.Replace_operator("r")<CR>', { desc = 'Replace line' })

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

-- Lsp mappings
map('n', '<leader>af', '<CMD>lua vim.lsp.buf.format { async = true }<CR>', { desc = 'Format' })

-- Git mappings
-- map('n', '<leader>gi', '<CMD>Git init<CR>', { desc = 'Git init' })
-- map('n', '<leader>ga', '<CMD>Git add .<CR>', { desc = 'Git add all' })
-- map('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = 'Git commit' })
-- map('n', '<leader>gA', '<CMD>Git commit --amend --no-edit -a<CR>', { desc = 'Git amend last commit' })
-- map('n', '<leader>gr', '<CMD>Git reset<CR>', { desc = 'Git unstage all' })
-- map('n', '<leader>gl', '<CMD>Git log --decorate --pretty=format:"%h - %an, %ar : %s"<CR>', { desc = 'Git pretty log' })
-- map('n', '<leader>gL', '<CMD>Git log<CR>', { desc = 'Git raw log' })
-- map('n', '<leader>gs', '<CMD>Git status<CR>', { desc = 'Git status' })
-- map('n', '<leader>gb', '<CMD>Git branch<CR>', { desc = 'Git branches' })
-- map('n', '<leader>gd', '<CMD>Git diff<CR>', { desc = 'Git diff' })
-- map('n', '<leader>gI', '<CMD>!touch .gitignore<CR>', { desc = 'Create git ignore' })

local function toggle_color_column()
    if vim.o.colorcolumn == '0' then
        vim.o.colorcolumn = '80'
    else
        vim.o.colorcolumn = '0'
    end
end

-- Toggle settings mappings
map('n', '<leader>tc', toggle_color_column, { desc = 'Toggle color column' })

-- Mouse keybinds
map('n', '<ScrollWheelUp>', 'k', { desc = 'Scroll up' })
map('n', '<ScrollWheelDown>', 'j', { desc = 'Scroll up' })

-- Tab/Shift+tab to indent/dedent
map('v', '<Tab>', '>gv', { desc = 'Indent line' })
map('n', '<Tab>', 'v><C-\\><C-N>', { desc = 'Indent line' })
map('v', '<S-Tab>', '<gv', { desc = 'Unindent line' })
map('n', '<S-Tab>', 'v<<C-\\><C-N>', { desc = 'Unindent line' })
