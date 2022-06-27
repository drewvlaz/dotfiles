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
# PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[blue]%}$%{$reset_color%}%b "

# Preferences
setopt autocd # Automatically cd into typed directory
setopt APPEND_HISTORY # Don't overwrite history
setopt SHARE_HISTORY # History shared between shells
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# History in cache directory:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.config/zsh/history

# Variables
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.scripts
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.pyenv/bin
export PATH=$PATH:~/.npm-global/bin
export PATH=$PATH:~/.local/share/gem/ruby/3.0.0/bin
export GOPATH=~/go
export GOPATH=$GOPATH~/golib
export SUDO_EDITOR=nvim
export EDITOR=nvim
# export EDITOR=lvim
# export BROWSER=firefox
# export FILEMANAGER=nautilus
# export RUST_BACKTRACE=full
export STARSHIP_CONFIG=~/.config/zsh/themes/starship/config.toml
# export TERM=xterm-256color
# Prevent double first character in commands
export LC_CTYPE=en_US.UTF-8
export XDG_RUNTIME_DIR=/run/user/1000

# Applications
export FZF_DEFAULT_OPTS="--layout=reverse --height=10"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

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

# Use nnn to switch directories
# nnncd() {
#     # Block nesting of nnn in subshells
#     if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
#         echo "nnn is already running"
#         return
#     fi

#     # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
#     # To cd on quit only on ^G, remove the "export" as in:
#     #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
#     # NOTE: NNN_TMPFILE is fixed, should not be modified
#     export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

#     # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
#     # stty start undef
#     # stty stop undef
#     # stty lwrap undef
#     # stty lnext undef

#     nnn "$@"

#     if [ -f "$NNN_TMPFILE" ]; then
#             . "$NNN_TMPFILE"
#             rm -f "$NNN_TMPFILE" > /dev/null
#     fi
# }

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

# Load themes
eval "$(starship init zsh)"
# source "$HOME/.config/zsh/themes/spaceshiprc"

source /usr/share/nvm/init-nvm.sh

# Load extensions ; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

