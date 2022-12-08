local status_ok, cokeline = pcall(require, 'cokeline')
if not status_ok then
    return
end

local get_hex = require('cokeline/utils').get_hex

local superscript_numbers = {
    ['0'] = '⁰',
    ['1'] = '¹',
    ['2'] = '²',
    ['3'] = '³',
    ['4'] = '⁴',
    ['5'] = '⁵',
    ['6'] = '⁶',
    ['7'] = '⁷',
    ['8'] = '⁸',
    ['9'] = '⁹',
}

local components = {
    space = {
        text = ' ',
    },
    two_space = {
        text = '  ',
    },
    separator = {
        text = '┃', -- ▎┃
        fg = function(buffer)
            return buffer.is_focused and get_hex('Special', 'fg')
        end,
    },
    devicon = {
        text = function(buffer)
            return buffer.devicon.icon
        end,
        fg = function(buffer)
            return buffer.devicon.color
        end,
    },
    index = {
        text = function(buffer)
            return tostring(buffer.index):gsub('.', function(c)
                return superscript_numbers[c] or ''
            end)
        end,
    },
    filename = {
        text = function(buffer)
            return buffer.filename
        end,
        fg = function(buffer)
            return buffer.is_modified and get_hex('WarningMsg', 'fg')
        end,
        truncation = {
            priority = 99,
            direction = 'right',
        },
    },
    modified = {
        text = function(buffer)
            return buffer.is_modified and '●' or ' '
        end,
        fg = get_hex('WarningMsg', 'fg'),
    },
}

local sidebar = {
    file_explorer = {
        filetype = 'neo-tree',
        components = {
            {
                text = function()
                    local text, width = 'File Explorer', 30
                    local left_padding = math.floor((width - string.len(text)) / 2)
                    return string.rep(' ', left_padding) .. text
                end,
                fg = get_hex('Normal', 'fg'),
                bg = get_hex('Normal', 'bg'),
            },
        },
    },
}

local bufferline = {
    components.separator,
    components.two_space,
    components.index,
    components.space,
    components.devicon,
    components.filename,
    components.space,
    components.modified,
    components.two_space,
}

cokeline.setup({
    buffers = {
        filter_valid = function(buffer)
            return buffer.filetype ~= 'vimwiki'
        end,
    },
    rendering = {
        max_buffer_width = 30,
    },
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
        end,
        bg = function(buffer)
            return buffer.is_focused and get_hex('Normal', 'bg') or get_hex('Tabline', 'bg')
        end,
    },
    components = bufferline,
    sidebar = sidebar.file_explorer,
})

for i = 1, 9 do
    vim.keymap.set(
        'n',
        ('<leader>%s'):format(i),
        ('<Plug>(cokeline-focus-%s)'):format(i),
        { desc = ('Buffer %s'):format(i) }
    )
end

vim.keymap.set('n', '<leader>y', '<Plug>(cokeline-focus-prev)', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>u', '<Plug>(cokeline-focus-next)', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<Plug>(cokeline-pick-focus)', { desc = 'Pick buffer' })
local bufdelete_status = pcall(require, 'bufdelete')
if bufdelete_status then
    vim.keymap.set('n', '<leader>bq', '<CMD>Bdelete<CR>', { desc = 'Buffer delete' })
end

vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Tabline' })
