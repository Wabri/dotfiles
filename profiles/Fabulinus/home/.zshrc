# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# === Oh-my-zsh ===
export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="false"
ENABLE_CORRECTION="false"
DISABLE_FZF_AUTO_COMPLETION="false"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_DEFAULT_SESSION_NAME="Home"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"

plugins=(
  command-not-found
  docker 
  git 
  fzf 
  kitchen 
  tmux 
  vi-mode 
  vagrant 
  direnv 
)

source $ZSH/oh-my-zsh.sh

fpath=(~/.zsh.d/ $fpath)

# === Fzf ===
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# === Environment ===
[[ ! -f ~/.env ]] || source ~/.env

# === ALIASES ===
[[ ! -f ~/.aliases ]] || source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
