-- Main files
require('sanakan.settings')
require('sanakan.keymaps')

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
require('lazy').setup('sanakan.plugins', {
  defaults = {
    version = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Select theme -- { pywal, tokyonight, kanagawa, miramare, nordic, mellifluous }
pcall(function()
  local theme_name = os.getenv('NVIM-COLORSCHEME') or 'kanagawa'
  vim.cmd('silent! colorscheme ' .. theme_name)
end)

vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Tabline' })
