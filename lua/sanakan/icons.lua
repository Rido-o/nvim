local M = {}

M.icons = {
    telescope_prefix = '   ',
    os = {
        linux = '',
        mac = '',
        windows = '',
    },
    statusline = {
        vi_right_indicator = '█',
        lsp = '⎈ ',
        cursor_line_percentage = '☰ ',
        cursor_position = ' ',
        modified = '●',
    },
    tabline = {
        separator = '┃',
        modified = '●',
    },
    listchars = {
        trail = '-',
        tab = '  ',
        -- extends = '»',
        -- precedes = '«',
        -- nbsp = '⣿',
        -- eol = '¬',
    },
    diagnostics = {
        Error = ' ', -- 
        Warn = ' ', -- ⚠
        Hint = ' ', -- 
        Info = ' ', -- 
    },
    git = {
        added = '+', --  
        modified = '~', --  
        removed = '-', --  
        branch = ' ', -- 
        signs = '▎', -- │
    },
    kinds = {
        Text = '',
        Method = '',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = 'ﴯ',
        Interface = '',
        Module = '',
        Property = 'ﰠ',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
    },
}

M.icons2 = {
    kinds = {
        Array = ' ',
        Boolean = ' ',
        Class = ' ',
        Color = ' ',
        Constant = ' ',
        Constructor = ' ',
        Enum = ' ',
        EnumMember = ' ',
        Event = ' ',
        Field = ' ',
        File = ' ',
        Folder = ' ',
        Function = ' ',
        Interface = ' ',
        Key = ' ',
        Keyword = ' ',
        Method = ' ',
        Module = ' ',
        Namespace = ' ',
        Null = 'ﳠ ',
        Number = ' ',
        Object = ' ',
        Operator = ' ',
        Package = ' ',
        Property = ' ',
        Reference = ' ',
        Snippet = ' ',
        String = ' ',
        Struct = ' ',
        Text = ' ',
        TypeParameter = ' ',
        Unit = ' ',
        Value = ' ',
        Variable = ' ',
    },
}

return M.icons
