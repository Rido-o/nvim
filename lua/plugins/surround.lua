return {
    'kylechui/nvim-surround',
    opts = {
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
    },
}
