{
  # https://github.com/NvChad/NvChad/issues/956 # https://github.com/redyf/nix-flake-nvchad/tree/main
  # https://github.com/logaMaster/neovim/tree/main
  # nix run github:Rido-o/nvim
  description = "Rido's neovim configuration";

  outputs = { self, ... }:
    let
      binpath = pkgs: with pkgs; lib.makeBinPath [
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
      ];
      nvim = pkgs: with pkgs; wrapNeovimUnstable neovim-unwrapped
        (neovimUtils.makeNeovimConfig
          {
            customRC = "source ${./.}/init.lua";
          } // {
          wrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${binpath pkgs}"
          ];
        });
    in
    {
      overlays = {
        sanakan-neovim = _: prev: { sanakan-neovim = nvim prev; };
        default = self.overlays.sanakan-neovim;
      };
    };
}
