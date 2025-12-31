#           _
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# Welcome message, don't display in tmux
# fortune -s -n 150 | cowsay -W 38 -f cower | lolcat
[ -z "${TMUX}" ] && [ -f "$HOME/.scripts/hashbang.sh" ] && "$HOME/.scripts/hashbang.sh"
# [ -f "$HOME/.scripts/hashbang.sh" ] && "$HOME/.scripts/hashbang.sh"

# Enable colors and change prompt (fallback for if starship is not installed):
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[blue]%}$%{$reset_color%}%b "

# Preferences
setopt autocd # Automatically cd into typed directory
setopt APPEND_HISTORY # Don't overwrite history
setopt SHARE_HISTORY # History shared between shells
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# History in cache directory:
HISTSIZE=8000
SAVEHIST=8000
HISTFILE=~/.config/zsh/history

# Variables
# export PATH=/opt/homebrew/Cellar/curl/8.9.1/bin:$PATH
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.scripts
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.pyenv/bin
export PATH=$PATH:~/.npm-global/bin
export PATH=$PATH:~/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:$HOME/npm/bin
export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/sessionmanagerplugin/bin
export GOPATH=~/go
export GOPATH=$GOPATH~/golib
export SUDO_EDITOR=nvim
export EDITOR=nvim
# export FILEMANAGER=nautilus
# export RUST_BACKTRACE=full
export RUST_LOG=trace
export STARSHIP_CONFIG=~/.config/zsh/themes/starship/config.toml
# export TERM=xterm-256color
# Prevent double first character in commands
export LC_CTYPE=en_US.UTF-8
export ANDROID_HOME=~/Library/Android/sdk
export MYVIMRC=~/.config/nvim/init.lua
export XDG_RUNTIME_DIR=/tmp/$USER-runtime

export AIDER_DARK_MODE=1
export AIDER_VIM=1
export AIDER_USER_INPUT_COLOR='#A7C080'

[ ! -f "$XDG_RUNTIME_DIR" ] && mkdir -p "$XDG_RUNTIME_DIR"

# Applications
export FZF_DEFAULT_OPTS="--layout=reverse --height=20 --prompt='❯ ' --pointer='❯ '"
eval "$(fzf --zsh)"
source ~/Documents/repos/fzf-git.sh/fzf-git.sh

eval "$(thefuck --alias)" 2>/dev/null

# Python
export PYTHONBREAKPOINT=IPython.terminal.debugger.set_trace
export PYTHONSTARTUP=~/.pythonrc.py

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt no_list_ambiguous

# vi mode
bindkey -v
#export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories
# lfcd() {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
get_file() {
  local pane_id=$(tmux display-message -p '#{pane_id}')
  local file=$(ls -a | fzf)
  [[ -n "$file" ]] && tmux send-keys -t "$pane_id" "$file"
}

# Custom ZSH Binds
bindkey -s '^o' 'get_file\n'
bindkey 'jk' vi-cmd-mode
bindkey '^ ' autosuggest-accept

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases if exist
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
[ -f "$HOME/.config/zsh/zfunctions" ] && source "$HOME/.config/zsh/zfunctions"
# [ -f "$HOME/.config/zsh/zoxiderc" ] && source "$HOME/.config/zsh/zoxiderc"
[ -f "$HOME/.secr" ] && source "$HOME/.secr" # secrets

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(/opt/homebrew/bin/mise activate zsh)"
setopt prompt_subst
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Load themes
eval "$(starship init zsh)" 2>/dev/null

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

# Load extensions ; should be last.
source ~/.config/zsh/plugins/zummoner/zummoner.zsh

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2>/dev/null
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
