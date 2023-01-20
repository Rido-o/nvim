-- Check mason requirements
return {
    'williamboman/mason.nvim',
    dependencies = {
        { 'williamboman/mason-lspconfig.nvim' },
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    config = function()
        if vim.g.distro == 'nixos' then
            return
        end

        require('mason').setup()

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
    end,
}
