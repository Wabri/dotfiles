#!/usr/bin/env bash

languages=`echo "awk ansible chef ruby bash python" | tr ' ' '\n'`
core_utils=`echo "find sed" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

execute="curl cht.sh/$selected"

if [[ $languages[*] =~ $selected ]]; then
	execute+='/'
else
	execute+='~'
fi
execute+="`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"

tmux neww "$execute"
