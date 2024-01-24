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
            wrapperArgs = [
              "--prefix"
              "PATH"
              ":"
              "${pkgs.lib.makeBinPath [
                pkgs.sumneko-lua-language-server
                pkgs.gcc
                pkgs.nil
                pkgs.nodePackages.pyright
                pkgs.statix
                pkgs.nixpkgs-fmt
                pkgs.stylua
                pkgs.black
                pkgs.gnumake
                pkgs.ripgrep
                pkgs.fd
                pkgs.lemonade # ssh clipboard
              ]}"
            ];
          }
          );
      });
    };
}
