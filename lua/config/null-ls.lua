local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
        require('null-ls').builtins.formatting.stylua,
        require('null-ls').builtins.formatting.black,
        require('null-ls').builtins.formatting.nixpkgs_fmt,
        require('null-ls').builtins.code_actions.statix,
        require('null-ls').builtins.diagnostics.statix,
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
