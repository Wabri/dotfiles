#     _    _ _           
#   / \  | (_) __ _ ___ 
#  / _ \ | | |/ _` / __|
# / ___ \| | | (_| \__ \
#/_/   \_\_|_|\__,_|___/
                       
alias ls='exa'
alias ll='ls -l'
alias la='ls -al'

alias cat='bat'

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Exit from bash with q
alias q='exit'

# apt
alias aptinst='sudo apt install -V'
alias aptupd='sudo apt update ; apt list --upgradable'
alias aptupg='sudo apt upgrade'
alias aptupgd='sudo apt update && sudo apt dist-upgrade -V && sudo apt autoremove'
alias aptrm='sudo apt remove'
alias aa='aptupd ; aptupgd'

# Vim
alias svim='sudoedit'

# Thefuck (https://github.com/nvbn/thefuck)
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias fk)

# Dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# taskbook
alias tb='clear ; task'
alias tbtask='task --task'
alias tbtime='clear ; task --timeline'
alias tbbegin='task --begin'
alias tbedit='task --edit'
alias tbcheck='task --check'
alias tbpriority='task --priority'
alias tbclear='task --clear'
alias tbrestore='task --restore'
alias tbstar='task --star'
alias tbdelete='task --delete'

