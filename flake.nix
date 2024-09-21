{
  description = "Rido's neovim configuration";

  outputs = { self, ... }:
    let
      binpath = pkgs: with pkgs; lib.makeBinPath [
        luajit # neorg
        unzip # neorg
        sumneko-lua-language-server
        gcc # treesitter # should work for fzf-native but wasn't
        nil # nix lsp
        nixd # nix lsp
        pyright
        statix
        biome # js/ts
        shellcheck
        nixpkgs-fmt
        stylua
        black
        gnumake # fzf-native
        ripgrep # telescope live_grep
        fd # telescope optional dependency
      ];
      nvim = pkgs: with pkgs; wrapNeovimUnstable neovim-unwrapped
        (neovimUtils.makeNeovimConfig
          {
            customRC = "source ${./.}/init.lua";
          } // {
          wrapperArgs = [ "--prefix" "PATH" ":" "${binpath pkgs}" ];
        });
    in
    {
      overlays = {
        sanakan-neovim = _: prev: { sanakan-neovim = nvim prev; };
        default = self.overlays.sanakan-neovim;
      };
    };
}
