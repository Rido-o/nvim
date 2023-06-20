return {
    'williamboman/mason.nvim', -- Check requirements
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    cond = vim.g.distro ~= 'NixOS',
    config = function()
        require('mason').setup()

        require('mason-lspconfig').setup({
            automatic_installation = true,
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                -- 'stylua',
                -- 'flake8',
                -- 'black',
            },
            auto_update = false,
        })
    end,
}
