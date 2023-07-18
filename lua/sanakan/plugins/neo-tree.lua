-- Open neo-tree if closed, focus if unfocused and close if focused -- From neo-tree v2.0 reddit post
local focus_neo_tree = function()
    local renderer = require('neo-tree.ui.renderer')
    local manager = require('neo-tree.sources.manager')
    local cmd = require('neo-tree.command')
    local state = manager.get_state('filesystem')
    if renderer.window_exists(state) then
        if state.winid == vim.api.nvim_get_current_win() then
            renderer.close(state)
        else
            cmd.execute({})
        end
    else
        cmd.execute({})
    end
end

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '<leader>n', focus_neo_tree, desc = 'Focus on file explorer' },
    },
    init = function()
        vim.g.neo_tree_remove_legacy_commands = true -- remove legacy commands
    end,
    config = function()
        -- modify highlight groups
        local nt_bg = vim.api.nvim_get_hl_by_name('TabLine', true).background
        local sep_bg = vim.api.nvim_get_hl_by_name('Normal', true).background
        vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { fg = sep_bg, bg = sep_bg }) -- NOTE t separator is not correct
        vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = nt_bg })
        vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = nt_bg })

        -- cd if directory else open file
        local open_cwd = function(state)
            local node = state.tree:get_node()
            local cmds = require('neo-tree.sources.filesystem.commands')
            if node.type == 'file' then
                cmds.open(state)
            elseif node.type == 'directory' then
                cmds.set_root(state)
            end
        end

        require('neo-tree').setup({
            close_if_last_window = true,
            default_component_configs = {
                indent = {
                    with_markers = true,
                    with_expanders = true,
                    expander_collapsed = require('sanakan.icons').tree.collapsed,
                    expander_expanded = require('sanakan.icons').tree.expanded,
                },
                modified = {
                    symbol = require('sanakan.icons').tree.modified,
                    highlight = 'WarningMsg',
                },
            },
            window = {
                width = 30,
                mappings = {
                    ['<CR>'] = open_cwd,
                    ['l'] = 'open',
                    ['e'] = 'open',
                    ['h'] = 'close_node',
                    ['L'] = 'expand_all_nodes',
                    ['v'] = 'open_vsplit',
                    ['s'] = 'open_split',
                    ['n'] = {
                        'add',
                        config = {
                            show_path = 'relative',
                        },
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                },
                follow_current_file = true,
                group_empty_dirs = true,
                use_libuv_file_watcher = true,
                bind_to_cwd = false,
                window = {
                    mappings = {
                        ['H'] = 'navigate_up',
                        ['<BS>'] = 'navigate_up',
                        ['.'] = 'toggle_hidden',
                    },
                },
            },
        })
    end,
}
