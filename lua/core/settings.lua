-----------------
-- Settings
-----------------
local default_options = {
    background = 'dark',
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
    colorcolumn = '0', -- Set how far the color column should be
    scrolloff = 5, -- How close the cursor should be before the page scrolls
    timeoutlen = 250, -- Default is 1000, normally set to 500, used for which key
    updatetime = 250, -- For vim signify
    signcolumn = 'yes:1', -- Add permanant column for signs on the left
    termguicolors = true, -- Required for some color schemes and colorizer
    undodir = vim.fn.stdpath('cache') .. '/undo', -- Undo directory
    completeopt = { 'menuone', 'noselect' }, -- Set completeopt to have a better completion experience
    list = true,
    listchars = { trail = '-', tab = '  ' }, -- 'trail:­,tab:  ,extends:»,precedes:«,nbsp:⣿,eol:¬'
    laststatus = 3, -- Enables global statusline
    -- cmdheight = 0,                  -- Makes command line height 0 -- In preperation for when it is added to stable
    guifont = { 'Hack Nerd Font', ':h11' }, -- Font for gui nvim
    mouse = 'a', -- Enabled by default in 0.8
}

-- Set options
for k, v in pairs(default_options) do
    vim.opt[k] = v
end

-- Set leader keys
vim.g.mapleader = ' ' -- Map leader key
vim.g.maplocalleader = ',' -- Map local leader key

-- Get OS
local raw_os = vim.loop.os_uname().sysname
if string.find(raw_os, 'Windows') then
    vim.g.os = 'Windows'
elseif raw_os == 'Linux' then
    vim.g.os = 'Linux'
    -- Get Distro
    local distro = vim.fn.system("sed -n 's/^DISTRIB_ID=//p' /etc/*-release | tr -d '\n'")
    vim.g.distro = distro
end

-- Disable auto-commenting
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('DiableAutoComment', { clear = true }),
    command = 'setlocal formatoptions-=cro',
})

-- Set shell to Windows PowerShell if on windows. Relies on function in init.lua
vim.cmd([[
if g:os == 'Windows'
    set shell=powershell shellquote= shellpipe=\| shellxquote=
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
end
]])
