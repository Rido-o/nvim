local status_ok, mason = pcall(require, 'mason')
if not status_ok then
    return
end

if vim.g.distro == 'nixos' then
    return
end

mason.setup()

require('mason-lspconfig').setup({
    automatic_installation = true,
})

require('mason-tool-installer').setup({
    ensure_installed = {
        'stylua',
        'flake8',
        'black',
    },
    auto_update = false,
})
