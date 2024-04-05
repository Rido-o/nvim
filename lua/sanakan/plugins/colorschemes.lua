return {
  {
    'AlphaTechnolog/pywal.nvim',
    lazy = true,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      style = 'night',
      styles = {
        comments = { italic = false },
      },
    },
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      globalStatus = true,
      colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
    },
  },
  {
    'Shatur/neovim-ayu',
    lazy = true,
    opts = {
      mirage = true,
    },
  },
  {
    'RRethy/base16-nvim',
    lazy = true,
  },
  {
    'franbach/miramare',
    lazy = true,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = true,
    config = function()
      require('nordic').setup({
        theme = 'onedark',
      })
      require('nordic').load()
    end,
  },
}
