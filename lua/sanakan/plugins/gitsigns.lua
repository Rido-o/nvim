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
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Actions
      map('n', ']h', gs.next_hunk, 'Nexk Hunk')
      map('n', '[h', gs.prev_hunk, 'Prev Hunk')
      map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
      map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
      map('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
      map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
      map('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')
      map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>gb', function()
        gs.blame_line({ full = true })
      end, 'Toggle blame')
      map('n', '<leader>gB', gs.toggle_current_line_blame, 'Toggle current line blame')
      map('n', '<leader>gd', gs.diffthis, 'Diff this')
      map('n', '<leader>gD', function()
        gs.diffthis('~')
      end, 'Diff this root')
      map('n', '<leader>gx', gs.toggle_deleted, 'Toggle deleted lines')
      map('n', '<leader>gt', '<CMD>Gitsigns toggle_signs<CR>', 'Toggle signs')

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'inner hunk')
    end,
  },
}
