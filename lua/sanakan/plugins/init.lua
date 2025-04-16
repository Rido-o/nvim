return {
  {
    'NvChad/nvim-colorizer.lua',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' }, -- │ ┊
    },
  },
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
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },
  {
    'nvim-neorg/neorg', -- TODO Add local leader bindings for norg files
    dependencies = {
      'luarocks.nvim',
    },
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
        ['core.completion'] = {
          config = {
            engine = 'nvim-cmp',
          },
        },
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
  {
    'ggandor/leap.nvim',
    dependencies = {
      -- can repeat.vim for . functionality
      'ggandor/flit.nvim', -- enhanced f/t motions
      config = true,
      keys = {
        { 'f', mode = { 'n', 'x' } },
        { 'F', mode = { 'n', 'x' } },
        { 't', mode = { 'n', 'x' } },
        { 'T', mode = { 'n', 'x' } },
      },
    },
    keys = {
      {
        's',
        function()
          require('leap').leap({ target_windows = { vim.fn.win_getid() } })
        end,
        mode = { 'n', 'x' },
      },
    },
    config = function()
      require('leap').set_default_keymaps() -- might not be needed with keys set
    end,
  },
  {
    'famiu/bufdelete.nvim',
    cmd = 'Bdelete',
    keys = {
      { '<leader>bq', '<CMD>Bdelete<CR>', desc = 'Buffer delete' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    cond = vim.fn.executable('gcc') == 1,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'python',
        'nix',
        'bash',
        'regex',
        'markdown',
        'markdown_inline',
        'javascript',
        'css',
        'typescript',
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { '<leader>c', '<plug>(comment_toggle_linewise_current)', mode = 'n', desc = 'Toggle comment' },
      { '<leader>c', '<plug>(comment_toggle_linewise_visual)', mode = 'x', desc = 'Toggle comment' },
    },
    config = true,
  },
  {
    'kylechui/nvim-surround',
    config = true,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
  {
    'mfussenegger/nvim-lint',
    config = function(_, _)
      require('lint').linters_by_ft = {
        nix = { 'statix' },
        sh = { 'shellcheck' },
      }
      vim.api.nvim_create_autocmd({ 'TextChanged', 'BufEnter', 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
