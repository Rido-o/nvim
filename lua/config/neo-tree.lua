local status_ok, neo_tree = pcall(require, 'neo-tree')
if not status_ok then
    return
end

-- remove legacy commands
vim.g.neo_tree_remove_legacy_commands = true

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

neo_tree.setup({
    close_if_last_window = true,
    default_component_configs = {
        indent = {
            with_markers = true,
            with_expanders = true,
            expander_collapsed = '‣',
            expander_expanded = '⏷',
        },
        modified = {
            symbol = '●',
            highlight = 'WarningMsg',
        },
    },
    renderers = {
        -- Default settings except without error icon
        directory = {
            { 'indent' },
            { 'icon' },
            { 'current_filter' },
            {
                'container',
                width = '100%',
                right_padding = 0,
                content = {
                    { 'name', zindex = 10 },
                    { 'clipboard', zindex = 10 },
                },
            },
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
    source_selector = {
        winbar = true,
    },
})

-- Open neo-tree if closed, focus if unfocused and close if focused -- From neo-tree v2.0 reddit post
local renderer = require('neo-tree.ui.renderer')
local manager = require('neo-tree.sources.manager')
local cmd = require('neo-tree.command')

local focus_neo_tree = function()
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

vim.keymap.set('n', '<leader>n', focus_neo_tree, { noremap = true, silent = true, desc = 'Focus on file explorer' })
