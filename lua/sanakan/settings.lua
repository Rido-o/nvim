-- Options
local opt = vim.opt

opt.encoding = 'utf-8' -- The encoding displayed is UTF-8 by default
opt.fileencoding = 'utf-8'
opt.fileencodings = 'utf-8' -- Causes problems with fugitive
opt.splitbelow = true
opt.splitright = true
opt.clipboard = 'unnamedplus'
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.linespace = 0 -- Set the space between lines
opt.expandtab = true -- Convert tabs to spaces
opt.tabstop = 2
opt.softtabstop = 2 -- Set the width of tabs and space tabs
opt.shiftwidth = 2 -- Change the number of space character for indentation
opt.smartindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 5 -- How close the cursor should be before the page scrolls
opt.timeoutlen = 250 -- Default is 1000, used for which key
opt.updatetime = 250 -- For vim signify ? not needed?
opt.signcolumn = 'yes:1' -- Add permanant column for signs on the left
opt.termguicolors = true
opt.undodir = vim.fn.stdpath('cache') .. '/undo'
opt.completeopt = { 'menuone', 'noselect' } -- Set completeopt to have a better completion experience
opt.pumheight = 10 -- completion height
opt.list = true
opt.listchars = require('sanakan.icons').listchars
opt.laststatus = 3 -- Enables global statusline

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Disable auto-commenting
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('DiableAutoComment', { clear = true }),
  command = 'setlocal formatoptions-=cro',
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd('VimResized', {
  command = 'tabdo wincmd =',
})
