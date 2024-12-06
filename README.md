My dotfiles.

Debian dependencies:

    apt install build-essential curl direnv fzf git htop jq neovim net-tools npm python3-pip stow zsh

oh-my-zsh:

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Install with:

    stow -t ~ omz
    stow -t ~ nvim
    stow -t ~ tmux
