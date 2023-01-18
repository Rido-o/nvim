local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    return
end

autopairs.setup({
    check_ts = true,
    ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
    },
})

-- nvim-cmp integration, add () for lsp functions, test with require in lua
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_status, cmp = pcall(require, 'cmp')
if cmp_status then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
