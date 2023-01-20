-- Main files
require('settings')
require('keymaps')

-- Lazy Bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Management
require('lazy').setup('plugins', {
    change_detection = {
        notify = false,
    },
})

-- Select theme -- { pywal, tokyonight, kanagawa, miramare }
pcall(function()
    local theme_name = 'tokyonight'
    vim.cmd('silent! colorscheme ' .. theme_name)
end)
