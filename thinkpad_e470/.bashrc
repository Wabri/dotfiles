# BASHRC

# === INTERACTIVELY ===
case $- in
    *i*) ;;
      *) return;;
esac

# === HISTORY ===
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# === LAZY REDRAW ===
shopt -s checkwinsize

# === COMPLETION ===
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# === VIM ===
set -o vi

# === Completion ===
bind 'set completion-ignore-case on'

# === Update size ===
shopt -s checkwinsize
# === Change named directory ===
shopt -s autocd
# === Autocorrects cd misspellings ===
shopt -s cdspell
# === Save multi-line commands in history as single line ===
shopt -s cmdhist
# === Expand aliases ===
shopt -s expand_aliases 

# === Environment ===
if [ -f ~/.env ]; then
    source ~/.env
fi

# === ALIASES ===
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# === PROMPT ===
eval "$(starship init bash)"
