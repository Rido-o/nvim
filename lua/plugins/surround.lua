return {
    'kylechui/nvim-surround',
    config = function()
        require('nvim-surround').setup({
            surrounds = {
                ['('] = { add = { '(', ')' } },
                [')'] = { add = { '( ', ' )' } },
                ['{'] = { add = { '{', '}' } },
                ['}'] = { add = { '{ ', ' }' } },
                ['<'] = { add = { '<', '>' } },
                ['>'] = { add = { '< ', ' >' } },
                ['['] = { add = { '[', ']' } },
                [']'] = { add = { '[ ', ' ]' } },
            },
            aliases = {
                ['a'] = '<', -- Single character aliases apply everywhere
                ['b'] = '(',
                ['c'] = '{',
                ['r'] = '[',
            },
        })
    end,
}
