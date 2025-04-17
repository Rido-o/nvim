return {
  {
    'nvim-neorg/neorg-telescope',
    dependencies = {
      'nvim-neorg/neorg',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>fn', '<CMD>Telescope neorg switch_workspace<CR>', desc = 'Switch neorg workspace' },
    },
  },
  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1000,
  --   config = true,
  -- },
  {
    'nvim-neorg/neorg', -- TODO Add local leader bindings for norg files
    -- dependencies = {
    --   'luarocks.nvim',
    -- },
    ft = 'norg',
    cmd = 'Neorg',
    version = '*',
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/Documents/Notes',
              wiki = '~/.cfg/wiki',
            },
            index = 'index.norg',
          },
        },
        -- ['core.completion'] = {
        --   config = {
        --     engine = 'blink.cmp',
        --   },
        -- },
        ['core.integrations.telescope'] = {},
        ['core.keybinds'] = {
          config = {
            hook = function(keybinds)
              keybinds.map('norg', 'n', '<BS>', '<C-^>') -- :e#
            end,
          },
        },
      },
    },
    config = function(_, opts)
      require('neorg').setup(opts)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('NeorgSettings', { clear = true }),
        pattern = 'norg',
        callback = function()
          vim.o.conceallevel = 2
          vim.o.foldlevel = 7
        end,
      })
    end,
  },
}
