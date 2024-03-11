# Created by newuser for 5.9

# Variable global
export STARSHIP_CONFIG="/home/nonotor/.config/starship/starship.toml"
export XDG_SCREENSHOTS_DIR="/home/nonotor/Pictures/Screenshots"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export VISUAL=nvim
export EDITOR=nvim

# Désactive le beep tabulation
unsetopt beep

#binds -- see command zle -al -- cat to find keycode
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word

# aliases
alias ls='ls --color=auto -F'
alias la='ls -a --color=auto -F'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c=auto'
alias tree='tree -F'
alias cls='clear'
alias py='python3'
alias asciiquarium='asciiquarium -t -s'
# custom commands
rangercd () { #ranger quit on where it was
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
    }
alias ranger="rangercd" 
alias myip="curl http://ipecho.net/plain; echo"

mkcd() {
    mkdir "$1" && cd "$1"
}

buds() {
    if [[ "$1" == "on" ]]; then
        bluetoothctl connect 24:11:53:44:51:AE
    elif [[ "$1" == "off" ]]; then
        bluetoothctl disconnect 24:11:53:44:51:AE
    else
        echo "Invalid argument"
    fi
}

# pfetch variables
export PF_INFO="ascii title os kernel shell wm uptime pkgs memory"
export PF_COL3=4 # Color for info names
export PF_COL2=9 # Color for info data
export PF_COL1=6 # Color for title
autoload -U promptinit && promptinit=6

# unset
unsetopt beep # disable beep on completion when pressing TAB

# init starship
eval "$(starship init zsh)"

# zsh history
SAVEHIST=2500 # save 2500 most-recent lines
HISTFILE="/home/nonotor/.zsh_history"

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format '%B%FCompleting %d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=5
zstyle ':completion:*:descriptions' format "%B%d%b"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%B%FAt %p: Hit TAB for more, or the character to insert%b%f'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt '%B%FScrolling active: current selection at %p%b%f'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# zsh plugins
source "/home/nonotor/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/home/nonotor/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
