#!/bin/bash
langs=$(echo "python c++ rust" | tr ' ' '\n')
selected=$(printf "$langs\n" | fzf)
read -p "search: " query
curl cht.sh/$selected/$(echo $query | tr ' ' '+') | less
