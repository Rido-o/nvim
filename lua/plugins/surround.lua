return {
    'kylechui/nvim-surround',
    event = 'InsertEnter',
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
    },
}
