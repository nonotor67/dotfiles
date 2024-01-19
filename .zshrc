# Options
setopt histignorealldups
setopt histignorespace
setopt interactivecomments
setopt menucomplete
setopt promptsubst
setopt sharehistory
setopt no_nomatch
setopt no_nullglob

# Exports
export PATH="${PATH}:${HOME}/.local/bin"
export LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export CCACHE_DIR="${XDG_CACHE_HOME}/ccache"
export CMAKE_GENERATOR=Ninja
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dsun.java2d.uiScale=1.25'
export KEYTIMEOUT=1
export VISUAL=nvim
export EDITOR=nvim

export GPG_TTY="$(tty)"

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.2
export QT_XCB_NO_XI2=1

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export LESS_TERMCAP_mb=$'\e[1;35m'
export LESS_TERMCAP_md=$'\e[94m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[0;37m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[91m'

# Aliases
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ip='ip -color=auto'
alias nighton='redshift -P -O 4000'
alias nightoff='redshift -P -O 6500'

# More aliases
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

xbox() {
    bluetoothctl disconnect 14:CB:65:A1:CF:8C
    bluetoothctl connect 14:CB:65:A1:CF:8C
}

night() {
    if [[ "$1" == "on" ]]; then
        redshift -P -O 3500
        light -S 50
    elif [[ "$1" == "off" ]]; then
        redshift -P -O 6500
        light -S 100
    else
        echo "Invalid argument"
    fi
}

cpp_ce() {
    cat <(rg '^#include "([^"]+)"' -r 'include/$1' "$1" | xargs cat) "$1" |
        sed -e 's/^#include ".\+//' -e 's/^static //' | xclip -sel clipboard
}

dotnet_publish_for_jitdisasm() {
    set -x
    dotnet publish -c Release
    local coreclr_bin_dir="${HOME}/projects/runtime/artifacts/bin/coreclr"
    local publish_dir="$(dirname "$1")/publish"
    cp -rT "${coreclr_bin_dir}/Linux.x64.Release" "${publish_dir}"
    cp "${coreclr_bin_dir}/Linux.x64.Debug/libclrjit.so" "${publish_dir}"
    set +x
}

# Prompt

print_prompt_git_info() {
    local branch_or_tag="$(git symbolic-ref --short HEAD 2> /dev/null || \
        git describe --exact-match HEAD 2> /dev/null)"

    if [[ -z "${branch_or_tag}" ]]; then
        return
    fi

    echo -n "%B%F{magenta}${branch_or_tag}%b%f"
    local num_changes="$(git status --porcelain | wc -l)"

    if [[ "${num_changes}" -gt "0" ]]; then
        echo -n "%B%F{yellow}*%b%f"
    fi

    echo -n " "
}

print_prompt_symbol() {
    if [[ "$1" -eq "0" ]]; then
        local symbol_color="green"
    else
        local symbol_color="red"
    fi

    echo -n "%B%F{${symbol_color}}➜%f%b "
}

print_prompt() {
    local exit_code="$?"
    echo -n "%B%F{cyan}%~%f%b "
    print_prompt_git_info
    print_prompt_symbol "${exit_code}"
}

PROMPT='$(print_prompt)'
VI_NORMAL_MODE_PROMPT="%B-- NORMAL --%b"

precmd() {
    RPROMPT=''
}

# Use the right prompt as an indicator for the Vi normal mode
function zle-line-init zle-keymap-select {
    RPROMPT='${${KEYMAP/vicmd/${VI_NORMAL_MODE_PROMPT}}/(main|viins)/}'
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Keybindings

# Enable Vi emulation
bindkey -v

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

# Keep 50000 lines of history within the shell and save it to ~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="${HOME}/.zsh_history"

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format '%B%F{blue}Completing %d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=5
zstyle ':completion:*:descriptions' format "%B%d%b"
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%B%F{blue}At %p: Hit TAB for more, or the character to insert%b%f'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt '%B%F{blue}Scrolling active: current selection at %p%b%f'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#SSH AGENT
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"


