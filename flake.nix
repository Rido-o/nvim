{
  # https://github.com/NvChad/NvChad/issues/956 # https://github.com/redyf/nix-flake-nvchad/tree/main
  description = "NvChad's Neovim Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    , ...
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        inherit (nixpkgs) lib;
        pkgs = nixpkgs.legacyPackages.${system};

        nvim =
          pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped
            (pkgs.neovimUtils.makeNeovimConfig
              {
                customRC = ''
                  set runtimepath^=${./.}
                  source ${./.}/init.lua
                '';
              }
              # // {
              #   wrapperArgs = [
              #     "--prefix"
              #     "PATH"
              #     ":"
              #     "${lib.makeBinPath [
              #       pkgs.sumneko-lua-language-server
              #       pkgs.gcc
              #       pkgs.nil
              #       pkgs.nodePackages.pyright
              #       pkgs.statix
              #       pkgs.nixpkgs-fmt
              #       pkgs.stylua
              #       pkgs.black
              #       pkgs.gnumake
              #       pkgs.ripgrep
              #       pkgs.fd
              #     ]}"
              #   ];
              # }
            );
      in
      {
        overlays = {
          neovim = _: _prev: {
            neovim = nvim;
          };
          default = self.overlays.neovim;
        };

        packages = rec {
          neovim = nvim;
          default = neovim;
        };

        # devShells.default = pkgs.mkShell {
        #   nativeBuildInputs = [
        #     pkgs.stylua
        #   ];
        # };
      }
    );
}
