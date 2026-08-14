# IDEConfigs

Some pretty decent and basic configs.

How to Install:<br>
Use NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" if running a passwordless sudo, if not use the command on the following line.<br>
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"<br>
brew install neovim<br>
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'<br>
nvim, then run :PlugInstall inside nvim<br>
sudo apt install gcc gcc-c++ make tree-sitter-cli<br>
If you are using an rpm based distro use the command on the next line instead of the command on the previous line<br>
sudo dnf install gcc gcc-c++ make tree-sitter-cli<br>
nvim, then run :TSInstall c cpp asm { all desired language parses }<br>
