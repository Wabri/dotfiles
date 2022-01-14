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

# === LOGIN ===
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# === CHROOT ===
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# === ALIASES ===
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# === Environment ===
export EDITOR='vim'

# === PROMPT ===
eval "$(starship init bash)"

export PATH="$PATH:$HOME/.poetry/bin"
