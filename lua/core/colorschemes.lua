-- Select theme -- { pywal, tokyonight, kanagawa, miramare }
pcall(function()
    local theme_name = 'tokyonight'
    vim.cmd('silent! colorscheme ' .. theme_name)
end)
