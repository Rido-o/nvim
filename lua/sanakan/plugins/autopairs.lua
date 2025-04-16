return {
  'windwp/nvim-autopairs',
  opts = {
    check_ts = true,
    ts_config = {
      lua = { 'string' }, -- it will not add a pair on that treesitter node
    },
  },
  event = 'InsertEnter',
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)
  end,
}
