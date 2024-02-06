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
      nvim = pkgs: pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped
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
              shellcheck
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
    in
    {
      packages = forAllSystems (pkgs: rec {
        neovim = nvim pkgs;
        default = neovim;
      });
      overlays = forAllSystems (pkgs: {
        neovim = _: _: { neovim = nvim pkgs; };
        default = self.overlays.neovim;
      });
    };
}
