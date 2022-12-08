-- Themes
local themes = {
    pywal = function()
        return 'pywal'
    end,
    tokyonight = function()
        vim.g.tokyonight_style = 'night'
        vim.g.tokyonight_disable_italic_comment = '1'
        return 'tokyonight'
    end,
    kanagawa = function()
        require('kanagawa').setup({ globalStatus = true })
        return 'kanagawa'
    end,
    miramare = function()
        return 'miramare'
    end,
}

-- Selected theme
pcall(function()
    local theme = themes.kanagawa()
    vim.cmd('silent! colorscheme ' .. theme)
end)
