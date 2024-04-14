# Installation guide

## Prequisuites
### Bare minimum
* neovim
* git
### General
* Hack-nerd - For font on gui nvim
* Lazygit - For git functionality
#### Keybinds
* python
* hyperfine
### Plugins
* gcc - For treesitter & telescope-fzf support
* ripgrep & fd - For telescope functionality
#### Mason
* pip
#### Lspconfig - Installed through mason except on nixos

# General installation guide
* Install neovim
* Install prerequisuites
* git clone https://github.com/Rido-o/nvim.git <nvim-config-path>
    * On windows path is '~/AppData/Local/nvim'
    * On linux path is '~/.config/nvim'
* run neovim

# Trying it out on nix
* not possible anymore, I think because i removed package output
* nix run github:Rido-o/nvim

# References
https://github.com/NvChad/NvChad/issues/956
https://github.com/redyf/nix-flake-nvchad/tree/main
https://github.com/logaMaster/neovim/tree/main
