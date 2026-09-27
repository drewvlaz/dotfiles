#           _
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# zmodload zsh/zprof

# Welcome message, don't display in tmux
[ -z "${TMUX}" ] && [ -f "$HOME/.scripts/hashbang.sh" ] && "$HOME/.scripts/hashbang.sh"

################################################################################
# Environment
################################################################################
typeset -U PATH path fpath # dedupe, since tmux panes inherit an already-built PATH

# Static `brew shellenv`; kept early so pyenv/nvm prepended below take precedence over brew's binaries
export HOMEBREW_PREFIX="/opt/homebrew" HOMEBREW_CELLAR="/opt/homebrew/Cellar" HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

export PATH=$PATH:$HOME/.local/bin:$HOME/.scripts

export EDITOR=nvim
export SUDO_EDITOR=nvim
export MYVIMRC=~/.config/nvim/init.lua
export STARSHIP_CONFIG=~/.config/zsh/themes/starship/config.toml
export LC_CTYPE=en_US.UTF-8 # Prevent double first character in commands
export XDG_RUNTIME_DIR=/tmp/$USER-runtime
[ -d "$XDG_RUNTIME_DIR" ] || mkdir -p "$XDG_RUNTIME_DIR"

export FZF_DEFAULT_OPTS="--layout=reverse --height=20 --prompt='❯ ' --pointer='❯ '"
export PYTHONBREAKPOINT=IPython.terminal.debugger.set_trace

# Python (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
# Shims alone make python/pip resolve; the full init (~140ms) is only needed by the pyenv command itself
export PATH="$PYENV_ROOT/shims:$PATH" PYENV_SHELL=zsh
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - zsh)"
  pyenv "$@"
}

# Node (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # `nvm use default` costs ~1.8s/shell
# Put the default node on PATH directly instead (newest installed version matching the default alias)
if [ -f "$NVM_DIR/alias/default" ]; then
  _nvm_default=($NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)*(N/On[1]))
  [ -n "$_nvm_default" ] && export PATH="$_nvm_default/bin:$PATH"
fi
unset _nvm_default

################################################################################
# Options and history
################################################################################
setopt autocd # Automatically cd into typed directory
setopt APPEND_HISTORY # Don't overwrite history
setopt SHARE_HISTORY # History shared between shells
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/history

# Fallback prompt for if starship is not installed
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[blue]%}$%{$reset_color%}%b "

################################################################################
# Completion
################################################################################
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
# only rebuild ~/.zcompdump if >24h old; otherwise fast path
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
_comp_options+=(globdots) # Include hidden files.

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt no_list_ambiguous

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

###-begin-gt-completions-###
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

################################################################################
# Vi mode and keybindings
################################################################################
bindkey -v

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
preexec() { echo -ne '\e[5 q' ;} # Reset to beam shape before each command.

get_file() {
  local pane_id=$(tmux display-message -p '#{pane_id}')
  local file=$(ls -a | fzf)
  [[ -n "$file" ]] && tmux send-keys -t "$pane_id" "$file"
}

bindkey -s '^o' 'get_file\n'
bindkey 'jk' vi-cmd-mode
bindkey '^ ' autosuggest-accept

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

################################################################################
# Tools, aliases, and functions
################################################################################
eval "$(fzf --zsh)"
source ~/dev/fzf-git.sh/fzf-git.sh

# `thefuck --alias` costs ~80ms, so define it on first use
fuck() {
  unfunction fuck
  eval "$(thefuck --alias)"
  fuck "$@"
}

[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
[ -f "$HOME/.config/zsh/zfunctions" ] && source "$HOME/.config/zsh/zfunctions"
[ -f "$HOME/.secr" ] && source "$HOME/.secr" # secrets

eval "$(starship init zsh)" 2>/dev/null # silence errors under TERM=dumb (e.g. agent shells)

# Load extensions ; should be last.
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# zprof
