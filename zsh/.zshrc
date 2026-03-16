# Gloabl variable
export "PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.npm/global/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# OMZ variables
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"

plugins=(git vi-mode fzf ssh-agent)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

export VISUAL='nvim'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.aliases ]] || source ~/.aliases

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

# ASDF variables
eval "$(asdf exec direnv hook zsh)"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"

export PATH=$PATH:$HOME/.spicetify
