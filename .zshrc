#           _
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# Welcome message, don't display in tmux
# fortune -s -n 150 | cowsay -W 38 -f cower | lolcat
[ -z "${TMUX}" ] && [ -f "$HOME/.scripts/hashbang.sh" ] && "$HOME/.scripts/hashbang.sh"
# [ -f "$HOME/.scripts/hashbang.sh" ] && "$HOME/.scripts/hashbang.sh"

# Enable colors and change prompt:
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
export GOPATH=~/go
export GOPATH=$GOPATH~/golib
export SUDO_EDITOR=nvim
export EDITOR=nvim
export BROWSER=google-chrome-stable
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

[ ! -f "$XDG_RUNTIME_DIR" ] && mkdir -p "$XDG_RUNTIME_DIR"

# Applications
export FZF_DEFAULT_OPTS="--layout=reverse --height=20 --prompt='❯ ' --pointer='❯ '"
eval "$(fzf --zsh)"
source ~/Documents/repos/fzf-git.sh/fzf-git.sh

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
lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Custom ZSH Binds
bindkey -s '^o' 'lfcd\n'
bindkey 'jk' vi-cmd-mode
bindkey '^ ' autosuggest-accept

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases if exist
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
[ -f "$HOME/.config/zsh/zfunctions" ] && source "$HOME/.config/zsh/zfunctions"
# [ -f "$HOME/.config/zsh/zoxiderc" ] && source "$HOME/.config/zsh/zoxiderc"

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(/opt/homebrew/bin/mise activate zsh)"
setopt prompt_subst
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Load themes
eval "$(starship init zsh)" 2>/dev/null

eval "$(thefuck --alias)" 2>/dev/null

# Load extensions ; should be last.
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null



