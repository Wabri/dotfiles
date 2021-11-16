export ZSH="/Users/$USER/.oh-my-zsh"

export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'

DISABLE_AUTO_UPDATE="true"

DISABLE_UPDATE_PROMPT="false"

ENABLE_CORRECTION="false"

plugins=(vi-mode vagrant tmux sudo kitchen fzf git docker colorize)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

fpath=(~/.zsh.d/ $fpath)

[ -f ~/.zsh/fzf.zsh ] && source ~/.zsh/fzf.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

function cd() {
  if [[ -d ./env ]] ; then
    deactivate
  fi

  builtin cd $1

  if [[ -d ./env ]] ; then
    . ./env/bin/activate
  fi
}

alias workspace=~/.local/bin/workspace-tmux

# => Git
alias g="git status"

# => Kitchen
alias kd="kitchen destroy -f ;" 
alias kc="kitchen converge ;"
alias kl="kitchen login ;"


# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)
