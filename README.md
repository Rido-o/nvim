# Installation guide
## Prequisuites
* git
* neovim
* python
* pip
* wget
* nodejs
* npm
* nvm & yarn?
* hyperfine
* If pip isn't added to path can use python -m pip install -U
* or sudo pacman -S python-pip

## Windows
* window specfic prerequisuites nerdfont hack
* clone nvim dotfiles into ~/AppData/Local/nvim
* add programs to path

## Linux
* sudo pacman -S wget neovim python python-pip nodejs npm hyperfine
* pip install pynvim black
* clone nvim dotfiles into $HOME/.config/nvim
* wget -xO $HOME/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
* run the command :PlugInstall
* open nvim to install coc extensions
* run :CocCommand clangd.install in a c/c++ file

* NEW!!
* install pyright
