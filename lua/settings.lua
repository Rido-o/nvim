-- Options
local opt = vim.opt

opt.encoding = 'utf-8' -- The encoding displayed is UTF-8 by default
opt.fileencoding = 'utf-8'
opt.fileencodings = 'utf-8' -- Causes problems with fugitive
opt.splitbelow = true -- Split down
opt.splitright = true -- Split right
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.number = true -- Print line number
opt.relativenumber = true -- Enables the relative numberline
opt.cursorline = true -- Change the cursor in insert mode
opt.linespace = 0 -- Set the space between lines
opt.expandtab = true -- Convert tabs to spaces
opt.tabstop = 4
opt.softtabstop = 4 -- Set the width of tabs and space tabs
opt.shiftwidth = 4 -- Change the number of space character for indentation
opt.smartindent = true -- Makes indenting smart
opt.wrap = false -- Display long lines as just one line
opt.swapfile = false -- Disable swap files
opt.backup = false -- Disable backup files
opt.undofile = true -- Allow undo files
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 5 -- How close the cursor should be before the page scrolls
opt.timeoutlen = 250 -- Default is 1000, used for which key
opt.updatetime = 250 -- For vim signify ? not needed?
opt.signcolumn = 'yes:1' -- Add permanant column for signs on the left
opt.termguicolors = true -- Required for some color schemes and colorizer
opt.undodir = vim.fn.stdpath('cache') .. '/undo' -- Undo directory
opt.completeopt = { 'menuone', 'noselect' } -- Set completeopt to have a better completion experience
opt.list = true
opt.listchars = { trail = '-', tab = '  ' } -- 'trail:­,tab:  ,extends:»,precedes:«,nbsp:⣿,eol:¬'
opt.laststatus = 3 -- Enables global statusline
opt.guifont = { 'Hack Nerd Font Mono:h11' } -- Font for gui nvim

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Get OS
local raw_os = vim.loop.os_uname().sysname
if string.find(raw_os, 'Windows') then
    vim.g.os = 'Windows'
elseif raw_os == 'Linux' then
    vim.g.os = 'Linux'
    -- Get Distro
    vim.g.distro = vim.fn.system("sed -n 's/^DISTRIB_ID=//p' /etc/*-release | tr -d '\n'")
end

-- Disable auto-commenting
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('DiableAutoComment', { clear = true }),
    command = 'setlocal formatoptions-=cro',
})

-- Set shell to Windows PowerShell if on windows -- :help shell-powershell
if vim.g.os == 'Windows' then
    opt({
        shell = 'pwsh.exe',
        shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command',
        shellxquote = '',
        shellquote = '',
        shellredir = '2>&1 | Out-File -Encoding UTF8 %s',
        shellpipe = '2>&1 | Out-File -Encoding UTF8 %s',
    })
end
