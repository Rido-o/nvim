{
  # https://github.com/NvChad/NvChad/issues/956 # https://github.com/redyf/nix-flake-nvchad/tree/main
  description = "NvChad's Neovim Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f rec {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      packages = forEachSupportedSystem ({ pkgs, system }: with pkgs; {
        default = wrapNeovimUnstable neovim-unwrapped
          (neovimUtils.makeNeovimConfig
            {
              customRC = ''
                set runtimepath^=${./.}
                source ${./.}/init.lua
              '';
            }
          //
          {
            wrapperArgs = [
              "--prefix"
              "PATH"
              ":"
              "${lib.makeBinPath [
                sumneko-lua-language-server
                gcc
                nil
                nodePackages.pyright
                statix
                nixpkgs-fmt
                stylua
                black
                gnumake
                ripgrep
                fd
                lemonade # ssh clipboard
              ]}"
            ];
          }
          );
      });
    };
}
