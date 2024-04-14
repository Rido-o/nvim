{
  # https://github.com/NvChad/NvChad/issues/956 # https://github.com/redyf/nix-flake-nvchad/tree/main
  # https://github.com/logaMaster/neovim/tree/main
  # nix run github:Rido-o/nvim
  description = "Rido's neovim configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = function: nixpkgs.lib.genAttrs systems (system: function nixpkgs.legacyPackages.${system});
      binpath = pkgs: pkgs.lib.makeBinPath (with pkgs; [
        luajit # needed for neorg
        unzip # also needed for neorg
        sumneko-lua-language-server
        gcc # for treesitter # should work for fzf-native but wasn't
        nil
        nodePackages.pyright
        statix
        shellcheck
        nixpkgs-fmt
        stylua
        black
        gnumake # for fzf-native
        ripgrep # for telescope live_grep
        fd # telescope optional dependency
      ]);
      nvim = pkgs: with pkgs; wrapNeovimUnstable neovim-unwrapped
        (neovimUtils.makeNeovimConfig
          {
            customRC = ''
              set runtimepath^=${./.}
              source ${./.}/init.lua
            '';
          } // {
          wrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${binpath pkgs}"
          ];
        });
    in
    rec {
      packages = forAllSystems (pkgs: rec {
        sanakan-neovim = nvim pkgs;
        default = sanakan-neovim;
      });
      overlays = {
        sanakan-neovim = _: _: { sanakan-neovim = packages.x86_64-linux.default; };
        default = self.overlays.sanakan-neovim;
      };
    };
}
