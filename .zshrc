# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE=/usr/bin/fzf

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git vi-mode fzf asdf vagrant tmux golang)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load direnv
eval "$(direnv hook zsh)"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

export PATH=$PATH:/home/wabri/.spicetify
