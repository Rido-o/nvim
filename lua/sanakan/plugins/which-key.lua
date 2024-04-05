return {
  'folke/which-key.nvim',
  opts = {
    operators = { gc = 'Comments', r = 'Replace' },
    window = {
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
  },
  config = function(_, opts)
    require('which-key').setup(opts)

    -- Disable whick-key for visual mode
    local presets = require('which-key.plugins.presets')
    presets.operators['v'] = nil

    -- Highlights
    vim.api.nvim_set_hl(0, 'WhichKeySeparator', { link = 'DiffAdded' })

    -- Give names to prefix keys
    require('which-key').register({
      -- Needed so that filetype bindings trigger whichkey
      ['<localleader>'] = { name = 'Filetype bindings' },
      ['<leader>'] = {
        b = { name = 'Buffers' },
        f = { name = 'Find' },
        a = { name = 'Lsp' },
        g = { name = 'Git' },
        W = {
          name = 'Vimwiki',
          ['<space>'] = { name = 'Vimwiki Diary' },
        },
        t = { name = 'Toggle' },
      },
    })
  end,
}
