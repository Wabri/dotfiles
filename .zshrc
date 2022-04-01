# === Oh-my-zsh ===
export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE="true"

DISABLE_UPDATE_PROMPT="false"

ENABLE_CORRECTION="false"

plugins=(vi-mode vagrant tmux kitchen fzf git docker)

source $ZSH/oh-my-zsh.sh

fpath=(~/.zsh.d/ $fpath)

# === Brew ===
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# === Fzf ===
[ -f ~/.zsh/fzf.zsh ] && source ~/.zsh/fzf.zsh

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

if [ -z "${TMUX}" ]; then
  tmux start-server
	sleep 5
  ~/.local/bin/tmux-commands/tmux-workspace full
fi

