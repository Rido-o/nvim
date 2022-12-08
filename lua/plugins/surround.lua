local status_ok, surround = pcall(require, 'nvim-surround')
if not status_ok then
    return
end

surround.setup({
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
