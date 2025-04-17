return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {},
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' }, -- │ ┊
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      highlight = { backdrop = false },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bufdelete = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
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
    'windwp/nvim-autopairs',
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
      },
    },
    event = 'InsertEnter',
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
