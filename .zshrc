if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/2.2.16/gems/vagrant-2.2.16/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)
fpath=(~/.zsh.d/ $fpath)

eval "$(starship init zsh)"

bindkey -v

[ -f ~/.zsh/fzf.zsh ] && source ~/.zsh/fzf.zsh
