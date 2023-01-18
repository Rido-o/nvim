local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end

-- Set lsp sign column signs
local signs = { Error = ' ', Warn = '⚠ ', Hint = ' ', Info = ' ' } -- 
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local function nmap(keys, func, desc)
        vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    nmap('<leader>ae', vim.diagnostic.open_float, 'Popup diagnostic')
    nmap('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
    nmap(']d', vim.diagnostic.goto_next, 'Next diagnostic')
    nmap('<leader>aq', vim.diagnostic.setloclist, 'Show diagnostic location list')
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    nmap('gD', vim.lsp.buf.declaration, 'Goto declaration')
    nmap('gd', vim.lsp.buf.definition, 'Goto definition')
    nmap('gr', vim.lsp.buf.references, 'Goto references')
    nmap('gi', vim.lsp.buf.implementation, 'Goto implementation')
    nmap('K', vim.lsp.buf.hover, 'Popup documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Popup help')
    nmap('<leader>aw', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
    nmap('<leader>aW', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
    nmap('<leader>al', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'List workspace folders')
    nmap('<leader>aD', vim.lsp.buf.type_definition, 'Goto type defintion')
    -- nmap('<leader>ar', vim.lsp.buf.rename, 'Rename text')
    -- nmap('<leader>aa', vim.lsp.buf.code_action, 'Show code actions')
    -- nmap('<leader>af', vim.lsp.buf.formatting, 'Format')
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Individual server settings
local settings = {
    sumneko_lua = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            telemetry = { enabled = false },
        },
    },
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'pyright', 'sumneko_lua', 'rnix' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings[lsp],
    })
end
