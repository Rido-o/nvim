return {
  'folke/which-key.nvim',
  opts = {
    -- defer = { gc = 'Comments', r = 'Replace' },
    win = {
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
    require('which-key').add({
      -- Needed so that filetype bindings trigger whichkey
      { '<localleader>', group = 'Filetype bindings' },
      { '<leader>b', group = 'Buffers' },
      { '<leader>f', group = 'Find' },
      { '<leader>a', group = 'Lsp' },
      { '<leader>t', group = 'Toggle' },
    })
  end,
}
