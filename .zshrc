# Created by newuser for 5.9

# Désactive le beep tabulation
unsetopt beep

# Variable global
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export VISUAL=nvim
export EDITOR=nvim
# pfetch variables
export PF_INFO="ascii title os kernel shell wm uptime pkgs memory"
export PF_COL3=4 # Color for info names
export PF_COL2=9 # Color for info data
export PF_COL1=6 # Color for title
autoload -U promptinit && promptinit=6

#binds -- see command zle -al -- cat to find keycode
bindkey "^[[2~" overwrite-mode # Insert
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[5~" up-line-or-history # Page Up
bindkey "^[[3~" delete-char # Delete
bindkey "^[[F" end-of-line # End
bindkey "^[[6~" down-line-or-history # Page Down
bindkey "^[[A" history-beginning-search-backward # Up
bindkey "^[[B" history-beginning-search-forward # Down
bindkey "^[[1;5C" forward-word # Ctrl+Left
bindkey "^[[1;5D" backward-word # Ctrl+Right

# custom commands
mkcd() {
  mkdir "$1" && cd "$1"
}

buds() {
  case $1 in 
    on)
      echo "Connecting Buds..."
      bluetoothctl connect 24:11:53:44:51:AE
      ;;
    off)
      echo "Disconnecting Buds..."
      bluetoothctl disconnect 24:11:53:44:51:AE
      ;;
    *)
      echo "Usage: buds [on|off]"
      ;;
  esac
}

# aliases
alias ls='ls --color=auto -F'
alias la='ls -a --color=auto -F'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c=auto'
alias tree='tree -F'
alias feh='feh -B black --scale-down'

# init starship
eval "$(starship init zsh)"

# zsh history
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"

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
source "$HOME/.config/zsh/zsh-completions/zsh-completions.plugin.zsh"
source "/home/nonotor/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# custom highlight : see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#D7FFFF,underline'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#D7FFFF,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#D7FFFF'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9CCCF2'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9CCCF2'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#D7FFFF'


source "/home/nonotor/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
