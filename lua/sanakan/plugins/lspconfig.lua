return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.inlay_hint.enable(true)
    vim.diagnostic.config({ virtual_text = true })

    local on_attach = function(_, bufnr)
      local function nmap(keys, func, desc)
        vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
      end

      nmap('<leader>ae', vim.diagnostic.open_float, 'Popup diagnostic')
      nmap('K', vim.lsp.buf.hover, 'Popup documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Popup help')
    end

    vim.lsp.enable({ 'pyright', 'lua_ls', 'biome', 'nixd' })
    vim.lsp.config('*', {
      on_attach = on_attach,
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = { enabled = false },
        },
      },
    })

    vim.lsp.config('nixd', {
      settings = {
        nixd = {
          nixpkgs = {
            expr = '(builtins.getFlake "/home/reid/.nix").nixosConfigurations.rei.pkgs',
          },
          formatting = {
            command = { 'alejandra' }, -- or nixfmt or nixpkgs-fmt
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake "/home/reid/.nix").nixosConfigurations.rei.options',
            },
            home_manager = {
              expr = '(builtins.getFlake "/home/reid/.nix").nixosConfigurations.rei.config.home-manager.users.reid',
            },
          },
        },
      },
    })
  end,
}
