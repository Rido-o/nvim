-----------------
-- Settings
-----------------
-- Set vimwiki location
if vim.g.os == 'Windows' then
    vim.g.vimwiki_list = {
        { ['path'] = '~/Documents/Wiki/' },
    }
elseif vim.g.os == 'Linux' then
    vim.g.vimwiki_list = {
        { ['path'] = '$HOME/.cfg/wiki/' },
    }
end
-- Set which keybindings are enabled
vim.g.vimwiki_key_mappings = {
    ['all_maps'] = 1,
    ['global'] = 0,
    ['headers'] = 1,
    ['text_objs'] = 1,
    ['table_format'] = 1,
    ['table_mappings'] = 0,
    ['lists'] = 0,
    ['links'] = 1,
    ['html'] = 1,
    ['mouse'] = 0,
}
-- Set vimwiki prefix
-- vim.g.vimwiki_map_prefix = '<space>W'
