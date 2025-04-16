local sign = require('sanakan.icons').git.signs

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  opts = {
    signs = {
      add = { text = sign },
      change = { text = sign },
      delete = { text = sign },
      topdelete = { text = sign },
      changedelete = { text = sign },
      untracked = { text = sign },
    },
  },
}
