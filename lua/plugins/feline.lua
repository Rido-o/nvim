local status_ok, feline = pcall(require, 'feline')
if not status_ok then
    return
end

local function get_col(group, id)
    return vim.fn.synIDattr(vim.fn.hlID(group), id)
end

local colors = {
    fg = '#DCD7BA',
    bg = '#16161D',
    black = '#1F1F28',
    darkgray = '#2A2A37',
    gray = '#363646',
    lightgray = '#54546D',
    skyblue = '#7FB4CA',
    cyan = '#7AA89F',
    green = '#76946A',
    oceanblue = '#7E9CD8',
    magenta = '#938AA9',
    orange = '#FFA066',
    red = '#C34043',
    violet = '#957FB8',
    white = '#C8C093',
    yellow = '#DCA561',
    errors = '#E82424',
    warnings = '#FF9E3B',
    info = '#6A9589',
    hints = '#658594',
}

local vi_mode_colors = {
    NORMAL = 'oceanblue',
    INSERT = 'green',
    VISUAL = 'violet',
    LINES = 'violet',
    BLOCK = 'violet',
    REPLACE = 'red',
    ['V-REPLACE'] = 'red',
    COMMAND = 'yellow',
}

local icons = {
    vi_right_indicator = '█',
    os_linux = '',
    os_mac = '',
    os_windows = '',
    diagnostic_errors = ' ',
    diagnostic_warnings = '⚠ ',
    diagnostic_hints = ' ',
    diagnostic_info = ' ',
    git_branch = ' ', -- 
    git_added = '+', -- 
    git_changed = '~', -- 
    git_removed = '-', -- 
    lsp = '⎈ ',
    cursor_line_percentage = '☰ ',
    cursor_position = ' ',
    file_modified = '●',
}

local function space_sep(color)
    return {
        str = ' ',
        hl = { bg = color },
    }
end

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = icons.os_linux
    elseif os == 'MAC' then
        icon = icons.os_mac
    else
        icon = icons.os_windows
    end
    return icon
end

local vi_mode_utils = require('feline.providers.vi_mode')

local components = {
    vi_mode = {
        provider = 'vi_mode',
        hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = 'bg',
                bg = vi_mode_utils.get_mode_color(),
                style = 'bold',
            }
        end,
        left_sep = {
            str = ' ',
            hl = function()
                return { bg = vi_mode_utils.get_mode_color() }
            end,
        },
        right_sep = {
            str = ' ',
            hl = function()
                return { bg = vi_mode_utils.get_mode_color() }
            end,
        },
        icon = '',
    },
    vi_right_indicator = {
        provider = icons.vi_right_indicator,
        hl = function()
            return { fg = vi_mode_utils.get_mode_color() }
        end,
    },
    file_info = {
        provider = {
            name = 'file_info',
            opts = {
                file_modified_icon = '',
                type = 'unique',
            },
        },
        short_provider = {
            name = 'file_info',
            opts = {
                file_modified_icon = '',
                type = 'base-only',
            },
        },
        hl = { fg = 'fg', bg = 'black' },
        left_sep = space_sep('black'),
        right_sep = space_sep('black'),
    },
    file_modified = {
        provider = function()
            return vim.bo.modified and icons.file_modified or ''
        end,
        hl = { fg = 'warnings', bg = 'black' },
        right_sep = space_sep('black'),
    },
    file_os = {
        provider = file_osinfo,
        hl = { bg = 'gray' },
        left_sep = space_sep('gray'),
    },
    file_encoding = {
        provider = function()
            return vim.bo.fileencoding
        end,
        hl = { bg = 'gray' },
        left_sep = space_sep('gray'),
        right_sep = space_sep('gray'),
    },
    file_type = {
        provider = 'file_type',
        hl = { bg = 'skyblue', fg = 'bg', style = 'bold' },
        left_sep = space_sep('skyblue'),
        right_sep = space_sep('skyblue'),
    },
    git_branch = {
        provider = 'git_branch',
        hl = { bg = 'darkgray', style = 'bold' },
        left_sep = space_sep('darkgray'),
        right_sep = space_sep('darkgray'),
        icon = {
            str = icons.git_branch,
            hl = { fg = 'orange', style = 'NONE' },
        },
    },
    git_diff_added = {
        provider = 'git_diff_added',
        hl = { fg = 'green', bg = 'darkgray', style = 'bold' },
        right_sep = space_sep('darkgray'),
        icon = icons.git_added,
    },
    git_diff_changed = {
        provider = 'git_diff_changed',
        hl = { fg = 'yellow', bg = 'darkgray', style = 'bold' },
        right_sep = space_sep('darkgray'),
        icon = icons.git_changed,
    },
    git_diff_removed = {
        provider = 'git_diff_removed',
        hl = { fg = 'red', bg = 'darkgray', style = 'bold' },
        right_sep = space_sep('darkgray'),
        icon = icons.git_removed,
    },
    cursor_line_percentage = {
        provider = 'line_percentage',
        hl = { bg = 'darkgray', style = 'bold' },
        left_sep = space_sep('darkgray'),
        right_sep = space_sep('darkgray'),
        icon = {
            str = icons.cursor_line_percentage,
            hl = { fg = 'cyan', style = 'NONE' },
        },
    },
    cursor_position = {
        provider = 'position',
        hl = { bg = 'darkgray', style = 'bold' },
        left_sep = space_sep('darkgray'),
        icon = {
            str = icons.cursor_position,
            hl = { fg = 'cyan', style = 'NONE' },
        },
    },
    diagnostic_errors = {
        provider = 'diagnostic_errors',
        hl = { bg = 'errors', fg = 'bg', style = 'bold' },
        left_sep = space_sep('errors'),
        right_sep = space_sep('errors'),
        icon = {
            str = icons.diagnostic_errors,
            hl = { style = 'NONE' },
        },
    },
    diagnostic_warnings = {
        provider = 'diagnostic_warnings',
        hl = { bg = 'warnings', fg = 'bg', style = 'bold' },
        left_sep = space_sep('warnings'),
        right_sep = space_sep('warnings'),
        icon = {
            str = icons.diagnostic_warnings,
            hl = { style = 'NONE' },
        },
    },
    diagnostic_hints = {
        provider = 'diagnostic_hints',
        hl = { bg = 'hints', fg = 'bg', style = 'bold' },
        left_sep = space_sep('hints'),
        right_sep = space_sep('hints'),
        icon = {
            str = icons.diagnostic_hints,
            hl = { style = 'NONE' },
        },
    },
    diagnostic_info = {
        provider = 'diagnostic_info',
        hl = { bg = 'info', fg = 'bg', style = 'bold' },
        left_sep = space_sep('info'),
        right_sep = space_sep('info'),
        icon = {
            str = icons.diagnostic_info,
            hl = { style = 'NONE' },
        },
    },
    lsp_names = {
        provider = 'lsp_client_names',
        hl = { bg = 'darkgray' },
        left_sep = space_sep('darkgray'),
        right_sep = space_sep('darkgray'),
        icon = {
            str = icons.lsp,
            hl = { fg = 'yellow' },
        },
        truncate_hide = true,
    },
    default = {
        provider = '',
    },
}

local statusline = {
    active = {
        { -- Left
            components.vi_mode,
            components.git_branch,
            components.git_diff_added,
            components.git_diff_changed,
            components.git_diff_removed,
            components.file_info,
            components.file_modified,
            components.diagnostic_errors,
            components.diagnostic_warnings,
            components.diagnostic_hints,
            components.diagnostic_info,
            components.default,
        },
        { -- Right
            components.lsp_names,
            components.file_os,
            components.file_encoding,
            components.file_type,
            components.cursor_position,
            components.cursor_line_percentage,
            components.vi_right_indicator,
        },
    },
    inactive = {
        { -- left
            components.vi_mode,
            components.file_info,
            components.default,
        },
        { -- right
            components.cursor_position,
            components.cursor_line_percentage,
            components.vi_right_indicator,
        },
    },
}

local force_inactive = {
    filetypes = {
        '^TelescopePrompt$',
        '^packer$',
        '^fugitive$',
        '^fugitiveblame$',
        '^qf$',
        '^help$',
        '^neo-tree$',
    },
    buftypes = {
        '^terminal$',
    },
    bufnames = {},
}

feline.setup({
    theme = colors,
    default_bg = 'bg',
    default_fg = 'fg',
    vi_mode_colors = vi_mode_colors,
    components = statusline,
    force_inactive = force_inactive,
})
