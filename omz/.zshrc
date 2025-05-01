# PATH
test -d /opt/homebrew/bin && export PATH="/opt/homebrew/bin:$PATH"
test -d /opt/homebrew/opt/mysql-client/bin && export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
test -d $HOME/.cargo/bin && export PATH="$HOME/.cargo/bin:$PATH"
test -d $HOME/src/dotfiles/scripts && export PATH="$HOME/src/dotfiles/scripts:$PATH"
test -d $HOME/.composer/vendor/bin && export PATH="$HOME/.composer/vendor/bin:$PATH"
test -d $HOME/go/bin && export PATH="$HOME/go/bin:$PATH"

# oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gentoo"
plugins=(debian git kubectl ansible direnv ssh-agent)
source $ZSH/oh-my-zsh.sh
unsetopt share_history

# envs
export EDITOR="nvim"
export WORKON_HOME=$HOME/.virtualenvwrapper

# aliases
alias vim=nvim
alias todo="vim ~/todo"

command -v pygmentize && alias ccat="pygmentize -g"
command -v eza >/dev/null && alias exa="eza"
command -v exa >/dev/null && alias ls="exa"
command -v exa >/dev/null && alias l="exa --git -l"
command -v exa >/dev/null && alias la="exa --git -la"
command -v terraform >/dev/null && alias tf="terraform"
command -v kubectl >/dev/null && alias k="kubectl"

# various inits
test -e /opt/homebrew/bin/terraform && complete -o nospace -C /opt/homebrew/bin/terraform terraform
test -e /opt/homebrew/bin/virtualenvwrapper.sh && source /opt/homebrew/bin/virtualenvwrapper.sh
test -e $HOME/.docker/init-zsh.sh && (source $HOME/.docker/init-zsh.sh || true)
test -e $HOME/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh || true
test -e $HOME/.jirarc && (source $HOME/.jirarc || true)

command -v devenv >/dev/null && eval "$(_DEVENV_COMPLETE=zsh_source devenv)"
command -v velero >/dev/null && . <(velero completion zsh)
command -v flux >/dev/null && . <(flux completion zsh)
command -v helm >/dev/null && . <(helm completion zsh)
command -v direnv >/dev/null && . <(direnv hook zsh)
