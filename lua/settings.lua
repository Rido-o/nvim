-- Set options
local function options(table)
    for k, v in pairs(table) do
        vim.opt[k] = v
    end
end

-- Options
options({
    encoding = 'utf-8', -- The encoding displayed is UTF-8 by default
    fileencoding = 'utf-8',
    fileencodings = 'utf-8', -- Causes problems with fugitive
    splitbelow = true, -- Split down instead of up
    splitright = true, -- Split right instead of left
    clipboard = 'unnamedplus', -- Copy and paste between everything
    number = true, -- Shows the current line number
    relativenumber = true, -- Enables the relative numberline
    cursorline = true, -- Change the cursor in insert mode
    linespace = 0, -- Set the space between lines
    expandtab = true,
    tabstop = 4,
    softtabstop = 4, -- Set the width of tabs and space tabs
    shiftwidth = 4, -- Change the number of space character for indentation
    smartindent = true, -- Makes indenting smart
    wrap = false, -- Display long lines as just one line
    swapfile = false, -- Disable swap files
    backup = false, -- Disable backup files
    undofile = true, -- Allow undo files
    ignorecase = true,
    smartcase = true,
    scrolloff = 5, -- How close the cursor should be before the page scrolls
    timeoutlen = 250, -- Default is 1000, normally set to 500, used for which key
    updatetime = 250, -- For vim signify ? not needed?
    signcolumn = 'yes:1', -- Add permanant column for signs on the left
    termguicolors = true, -- Required for some color schemes and colorizer
    undodir = vim.fn.stdpath('cache') .. '/undo', -- Undo directory
    completeopt = { 'menuone', 'noselect' }, -- Set completeopt to have a better completion experience
    list = true,
    listchars = { trail = '-', tab = '  ' }, -- 'trail:­,tab:  ,extends:»,precedes:«,nbsp:⣿,eol:¬'
    laststatus = 3, -- Enables global statusline
    guifont = { 'Hack Nerd Font Mono:h11' }, -- Font for gui nvim
})

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
    options({
        shell = 'pwsh.exe',
        shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command',
        shellxquote = '',
        shellquote = '',
        shellredir = '2>&1 | Out-File -Encoding UTF8 %s',
        shellpipe = '2>&1 | Out-File -Encoding UTF8 %s',
    })
end
