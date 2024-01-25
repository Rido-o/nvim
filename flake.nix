{
  # https://github.com/NvChad/NvChad/issues/956 # https://github.com/redyf/nix-flake-nvchad/tree/main
  # nix run github:Rido-o/nvim
  description = "Rido's neovim configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
    in
    rec {
      packages = forEachSupportedSystem ({ pkgs, system }: {
        default = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped
          (pkgs.neovimUtils.makeNeovimConfig
            {
              customRC = ''
                set runtimepath^=${./.}
                source ${./.}/init.lua
              '';
            }
          //
          {
            wrapperArgs = with pkgs; [
              "--prefix"
              "PATH"
              ":"
              "${lib.makeBinPath [
                sumneko-lua-language-server
                gcc # for treesitter # should work for fzf-native but wasn't
                nil
                nodePackages.pyright
                statix
                nixpkgs-fmt
                stylua
                black
                gnumake # for fzf-native
                ripgrep # for telescope live_grep
                fd # telescope optional dependency
              ]}"
            ];
          }
          );
      });
      overlays = rec {
        neovim = _: _: { neovim = packages.x86_64-linux.default; };
        default = neovim;
      };
    };
}
