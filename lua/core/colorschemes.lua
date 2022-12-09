-- Theme settings
local themes = {
    tokyonight = function()
        vim.g.tokyonight_style = 'night'
        vim.g.tokyonight_disable_italic_comment = '1'
    end,
    kanagawa = function()
        require('kanagawa').setup({ globalStatus = true })
    end,
}

-- Select theme -- { pywal, tokyonight, kanagawa, miramare }
pcall(function()
    local theme_name = 'kanagawa'
    pcall(themes[theme_name])
    vim.cmd('silent! colorscheme ' .. theme_name)
end)
