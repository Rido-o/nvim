return {
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
  },
}
