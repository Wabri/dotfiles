export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE="true"

DISABLE_UPDATE_PROMPT="false"

ENABLE_CORRECTION="false"

plugins=(vi-mode vagrant tmux kitchen fzf git docker)

source $ZSH/oh-my-zsh.sh

fpath=(~/.zsh.d/ $fpath)

[ -f ~/.zsh/fzf.zsh ] && source ~/.zsh/fzf.zsh

# >>>> Vagrant command completion (start)
#fpath=(/opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/contrib/zsh $fpath)
#compinit
# <<<<  Vagrant command completion (end)

# === Environment ===
if [ -f ~/.env ]; then
    source ~/.env
fi

# === ALIASES ===
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# === Prompt ===
eval "$(starship init zsh)"
