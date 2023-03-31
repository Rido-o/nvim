return {
    {
        'AlphaTechnolog/pywal.nvim',
        lazy = true,
    },
    {
        'folke/tokyonight.nvim',
        lazy = true,
        opts = {
            style = 'night',
            styles = {
                comments = { italic = false },
            },
        },
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = true,
        opts = {
            globalStatus = true,
        },
    },
    {
        'franbach/miramare',
        lazy = true,
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = true,
        config = function()
            require('nordic').load()
        end,
    },
}
