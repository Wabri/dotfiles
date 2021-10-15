#!/usr/bin/env bash

languages=`cat ~/.local/share/cht/languages | tr ' ' '\n'`
commands=`cat ~/.local/share/cht/commands | tr ' ' '\n'`

selected=`printf "$languages\n$commands" | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "query: " query

execute="curl cht.sh/$selected"

if [[ $languages[*] =~ $selected ]]; then
	execute+='/'
else
	execute+='~'
fi
execute+="`echo $query | tr ' ' '+'`& while [ : ]; do sleep 1; done"

tmux neww "$execute"

