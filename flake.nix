{
  description = "Rido's neovim configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    binpath = pkgs:
      with pkgs;
        lib.makeBinPath [
          luajit # neorg
          unzip # neorg
          sumneko-lua-language-server
          gcc # treesitter # should work for fzf-native but wasn't
          nil # nix lsp
          nixd # nix lsp
          pyright
          statix
          biome # js/ts
          prettierd
          shellcheck
          nixpkgs-fmt
          alejandra
          stylua
          black
          gnumake # fzf-native
          ripgrep # telescope live_grep
          fd # telescope optional dependency
          luajitPackages.luarocks
        ];
    nvim = pkgs:
      with pkgs;
        wrapNeovimUnstable neovim-unwrapped
        (neovimUtils.makeNeovimConfig
          {
            customRC = "source ${./.}/init.lua";
          }
          // {
            wrapperArgs = ["--prefix" "PATH" ":" "${binpath pkgs}"];
          });
  in {
    packages.x86_64-linux = {
      sanakan-neovim = nvim nixpkgs.legacyPackages.x86_64-linux;
      default = self.packages.sanakan-neovim;
    };
    overlays = {
      sanakan-neovim = _: prev: {sanakan-neovim = nvim prev;};
      default = self.overlays.sanakan-neovim;
    };
  };
}
