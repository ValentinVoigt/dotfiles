My dotfiles.

Debian dependencies:

    apt install build-essential curl direnv fzf git htop jq neovim net-tools npm python3-pip shfmt stow zsh

macOS dependencies:

    brew install direnv fzf htop jq neovim shfmt stow tree-sitter lua-language-server

oh-my-zsh:

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Install with:

    stow -t ~ omz
    stow -t ~ nvim
    stow -t ~ tmux

Current neovim on Debian:

    sudo apt remove neovim neovim-runtime
    sudo apt install ninja-build gettext cmake unzip curl
    git clone https://github.com/neovim/neovim
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build
    cpack -G DEB
    sudo dpkg -i --force-overwrite  nvim-linux64.deb
