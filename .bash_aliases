alias ls='exa'
alias ll='ls -l'
alias la='ls -al'

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

alias q='exit'

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# apt
alias aptinst='sudo apt install -V'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade'
alias aptupgd='sudo apt update && sudo apt dist-upgrade -V && sudo apt autoremove'
alias aptrm='sudo apt remove'
alias grep='rg'

# Vim
alias svim='sudo vim'

# Thefuck (https://github.com/nvbn/thefuck)
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias fk)


# Dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
