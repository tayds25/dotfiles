#!/usr/bin/env zsh
# =============================================================================
# ZSH Configuration
# =============================================================================

# =============================================================================
# INITIAL SETUP & SYSTEM INFO
# =============================================================================

# Display system info on shell startup (if fastfetch is available)
if command -v fastfetch &> /dev/null; then
    fastfetch
fi

# Load system-wide zsh configurations
[[ -f /etc/zshrc ]] && source /etc/zshrc

# =============================================================================
# XDG BASE DIRECTORIES
# =============================================================================
# Follow XDG Base Directory specification for better organization

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# =============================================================================
# ZSH SPECIFIC SETTINGS
# =============================================================================

# Enable extended globbing
setopt extended_glob

# Enable auto-completion case insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable menu selection for completions
zstyle ':completion:*' menu select

# Show completion list automatically
setopt auto_menu

# Change to directory by typing directory name (no cd needed)
setopt auto_cd

# Enable correction of commands
setopt correct

# Don't beep on errors
setopt no_beep

# Enable extended history
setopt extended_history

# Share history between all sessions
setopt share_history

# Append to history file immediately
setopt inc_append_history

# Remove older duplicate entries from history
setopt hist_ignore_all_dups

# Don't save commands that start with space
setopt hist_ignore_space

# Remove extra blanks from history
setopt hist_reduce_blanks

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTTIMEFORMAT="%F %T"

# Create history directory if it doesn't exist
[[ ! -d "$XDG_STATE_HOME/zsh" ]] && mkdir -p "$XDG_STATE_HOME/zsh"

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# Default editors
export EDITOR=micro
export VISUAL=micro

# Terminal and color support
export CLICOLOR=1
export TERM="xterm-256color"

# Custom directory for scripts/tools
export LINUXTOOLBOXDIR="$HOME/linuxtoolbox"

# Rust/Cargo binaries
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Ruby gems
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.gems/bin:$PATH"

# Flatpak applications
export PATH="$PATH:/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin"

# Custom application paths
export PATH="$PATH:$HOME/.spicetify:/opt/yazi"

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# =============================================================================
# LS COLORS & GREP COLORS
# =============================================================================

# Enhanced LS_COLORS for better file type visualization
export LS_COLORS='no=00:fi=00:di=34:ln=36:pi=33:so=35:do=35:bd=33;01:cd=33;01:or=31;01:ex=32:*.tar=31:*.tgz=31:*.arj=31:*.taz=31:*.lzh=31:*.zip=31:*.z=31:*.Z=31:*.gz=31:*.bz2=31:*.deb=31:*.rpm=31:*.jar=31:*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.pbm=35:*.pgm=35:*.ppm=35:*.tga=35:*.xbm=35:*.xpm=35:*.tif=35:*.tiff=35:*.png=35:*.mov=35:*.mpg=35:*.mpeg=35:*.avi=35:*.fli=35:*.gl=35:*.dl=35:*.xcf=35:*.xwd=35:*.ogg=35:*.mp3=35:*.wav=35:*.flac=35:*.xml=31:ow=34;40:tw=34;40'

# Man page colors (makes reading easier)
export LESS_TERMCAP_mb=$'\E[01;31m'    # Begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'    # Begin bold
export LESS_TERMCAP_me=$'\E[0m'        # End mode
export LESS_TERMCAP_se=$'\E[0m'        # End standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m' # Begin standout-mode
export LESS_TERMCAP_ue=$'\E[0m'        # End underline
export LESS_TERMCAP_us=$'\E[01;32m'    # Begin underline

# FZF default options
export FZF_DEFAULT_OPTS="--ansi --height 80% --layout=reverse --border"

# =============================================================================
# SYSTEM-SPECIFIC ALIASES
# =============================================================================

# Web development
alias web='cd /var/www/html'

# System management
alias shutdown='sudo poweroff'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Package management (Ubuntu/Debian focus)
alias apt-get='sudo apt-get'
alias packages='apt-cache search . | fzf --preview "apt-cache show {1}"'

# Service management aliases
alias hug="systemctl --user restart hugo"
alias lanm="systemctl --user restart lan-mouse"

# =============================================================================
# GENERAL PRODUCTIVITY ALIASES
# =============================================================================

# File operations (with safety features)
alias cp='cp -i'                           # Confirm before overwrite
alias mv='mv -i'                           # Confirm before overwrite  
alias rm='trash -v'                        # Use trash instead of rm
alias mkdir='mkdir -p'                     # Create parent directories

# Enhanced ls commands
alias ls='ls -aFh --color=always'          # Basic colorized listing
alias la='ls -Alh'                         # Show all files including hidden
alias ll='ls -Fls'                         # Long listing format
alias lx='ls -lXBh'                        # Sort by extension
alias lk='ls -lSrh'                        # Sort by size
alias lc='ls -ltcrh'                       # Sort by change time
alias lu='ls -lturh'                       # Sort by access time
alias lr='ls -lRh'                         # Recursive listing
alias lt='ls -ltrh'                        # Sort by date
alias lm='ls -alh | more'                  # Pipe through more
alias lw='ls -xAh'                         # Wide listing format
alias labc='ls -lap'                       # Alphabetical sort
alias lf="ls -l | egrep -v '^d'"           # Files only
alias ldir="ls -l | egrep '^d'"            # Directories only

# Directory navigation
alias ..='cd ..'                           # Go up one directory
alias ...='cd ../..'                       # Go up two directories  
alias ....='cd ../../..'                   # Go up three directories
alias .....='cd ../../../..'               # Go up four directories
alias bd='cd "$OLDPWD"'                    # Go to previous directory
alias home='cd ~'                          # Go to home directory

# System information & monitoring
alias ps='ps auxf'                         # Enhanced process list
alias ping='ping -c 10'                    # Limit ping to 10 packets
alias openports='netstat -nape --inet'     # Show open network ports
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# File permissions
alias mx='chmod a+x'                       # Make executable
alias 000='chmod -R 000'                   # No permissions
alias 644='chmod -R 644'                   # Read/write for owner, read for others
alias 666='chmod -R 666'                   # Read/write for all
alias 755='chmod -R 755'                   # Full for owner, read/execute for others
alias 777='chmod -R 777'                   # Full permissions for all

# Archive operations
alias mktar='tar -cvaf'                    # Create archive (auto-detect compression)
alias untar='tar -xvaf'                    # Extract archive (auto-detect compression)
alias mktr='tar -cvf'                      # Create tar
alias mkbz2='tar -cvjf'                    # Create bzip2
alias mkgz='tar -cvzf'                     # Create gzip
alias unbz2='tar -xvjf'                    # Extract bzip2
alias ungz='tar -xvzf'                     # Extract gzip

# Text processing and search
alias less='less -R'                       # Enable color in less
alias h="history | grep"                   # Search command history
alias p="ps aux | grep"                    # Search running processes
alias f="find . | grep"                    # Search files in current directory
alias ftext='grep -iIHrn --color=always'   # Search text in files

# System utilities
alias cls='clear'                          # Clear screen
alias da='date "+%Y-%m-%d %A %T %Z"'       # Show formatted date
alias diskspace="du -S | sort -n -r | more" # Show disk usage
alias folders='du -h --max-depth=1'        # Show folder sizes
alias mountedinfo='df -hT'                 # Show mounted filesystems
alias tree='tree -CAhF --dirsfirst'        # Enhanced tree view
alias treed='tree -CAFd'                   # Tree view (directories only)

# Development tools
alias nv='nvim'                            # Use neovim instead of vi
alias vim='nvim'                           # Use neovim instead of vim
alias nano='micro'                         # Use micro instead of nano
alias svi='sudo nvim'                      # Sudo vi
alias spico='sudo pico'                    # Sudo pico
alias snano='sudo nano'                    # Sudo nano

# Network utilities
alias whatismyip="whatsmyip"               # IP address lookup

# Docker utilities
alias docker-clean='docker container prune -f; docker image prune -f; docker network prune -f; docker volume prune -f'

# =============================================================================
# TOOL-SPECIFIC CONFIGURATIONS
# =============================================================================

# Use ripgrep if available, otherwise fall back to grep
if command -v rg &> /dev/null; then
    alias grep='rg'
else
    alias grep="/usr/bin/grep --color=auto"
fi

# Use bat/batcat for syntax highlighting (distribution-specific)
if command -v bat &> /dev/null; then
    alias cat='bat'
elif command -v batcat &> /dev/null; then
    alias cat='batcat'
fi

# FZF enhanced aliases
alias fzfp='fzf --height 100% --preview "bat --style=plain --color=always {}"'
alias fzfcode='code "$(fzf --height 100% --preview "bat --style=plain --color=always {}")"'

# =============================================================================
# CUSTOM FUNCTIONS
# =============================================================================

# Extract various archive formats
extract() {
    for archive in "$@"; do
        if [[ -f "$archive" ]]; then
            case $archive in
                *.tar.bz2) tar xvjf $archive ;;
                *.tar.gz) tar xvzf $archive ;;
                *.bz2) bunzip2 $archive ;;
                *.rar) rar x $archive ;;
                *.gz) gunzip $archive ;;
                *.tar) tar xvf $archive ;;
                *.tbz2) tar xvjf $archive ;;
                *.tgz) tar xvzf $archive ;;
                *.zip) unzip $archive ;;
                *.Z) uncompress $archive ;;
                *.7z) 7z x $archive ;;
                *) echo "Don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Navigate up multiple directories (usage: up 3)
up() {
    local d=""
    local limit=$1
    for ((i=1; i<=limit; i++)); do
        d="$d/.."
    done
    d=${d#/}
    if [[ -z "$d" ]]; then
        d=".."
    fi
    cd $d
}

# Create directory and navigate to it
mkdirg() {
    mkdir -p "$1" && cd "$1"
}

# Copy file and navigate to destination (if directory)
cpg() {
    if [[ -d "$2" ]]; then
        cp "$1" "$2" && cd "$2"
    else
        cp "$1" "$2"
    fi
}

# Move file and navigate to destination (if directory)
mvg() {
    if [[ -d "$2" ]]; then
        mv "$1" "$2" && cd "$2"
    else
        mv "$1" "$2"
    fi
}

# Get IP addresses (internal and external)
whatsmyip() {
    echo -n "Internal IP: "
    if command -v ip &> /dev/null; then
        ip addr show $(ip route | awk '/default/ {print $5}' | head -n1) | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        ifconfig | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | head -n1
    fi
    
    echo -n "External IP: "
    curl -s -4 ifconfig.me && echo
}

# Count files in directory
countfiles() {
    for t in files links directories; do 
        echo $(find . -type ${t:0:1} | wc -l) $t
    done 2> /dev/null
}

# Git shortcuts
gcom() {
    git add .
    git commit -m "$1"
}

lazyg() {
    git add .
    git commit -m "$1"
    git push
}

# Yazi file manager with directory change
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    local cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# FZF directory navigation
fzfdir() {
    local selected_file=$(fzf --height 80%)
    if [[ -n "$selected_file" ]]; then
        nemo "$(dirname "$selected_file")" & disown
    fi
}

# Hastebin-like service
hb() {
    if [[ $# -eq 0 ]]; then
        echo "No file path specified."
        return 1
    elif [[ ! -f "$1" ]]; then
        echo "File path does not exist."
        return 1
    fi

    local uri="http://bin.christitus.com/documents"
    local response=$(curl -s -X POST -d @"$1" "$uri")
    if [[ $? -eq 0 ]]; then
        local hasteKey=$(echo $response | jq -r '.key')
        echo "http://bin.christitus.com/$hasteKey"
    else
        echo "Failed to upload the document."
    fi
}

# Get current Linux distribution type
distribution() {
    local dtype="unknown"
    
    if [[ -r /etc/os-release ]]; then
        source /etc/os-release
        case $ID in
            fedora|rhel|centos) dtype="redhat" ;;
            sles|opensuse*) dtype="suse" ;;
            ubuntu|debian) dtype="debian" ;;
            gentoo) dtype="gentoo" ;;
            arch|manjaro) dtype="arch" ;;
            slackware) dtype="slackware" ;;
            *)
                if [[ -n "$ID_LIKE" ]]; then
                    case $ID_LIKE in
                        *fedora*|*rhel*|*centos*) dtype="redhat" ;;
                        *sles*|*opensuse*) dtype="suse" ;;
                        *ubuntu*|*debian*) dtype="debian" ;;
                        *gentoo*) dtype="gentoo" ;;
                        *arch*) dtype="arch" ;;
                        *slackware*) dtype="slackware" ;;
                    esac
                fi
                ;;
        esac
    fi
    echo $dtype
}

# Show OS version information
ver() {
    local dtype=$(distribution)
    
    case $dtype in
        "redhat")
            [[ -s /etc/redhat-release ]] && cat /etc/redhat-release || cat /etc/issue
            uname -a
            ;;
        "suse") cat /etc/SuSE-release ;;
        "debian") lsb_release -a ;;
        "gentoo") cat /etc/gentoo-release ;;
        "arch") cat /etc/os-release ;;
        "slackware") cat /etc/slackware-version ;;
        *)
            [[ -s /etc/issue ]] && cat /etc/issue || echo "Error: Unknown distribution"
            ;;
    esac
}

# Auto-ls after cd (zsh-specific implementation)
chpwd() {
    ls
}

# Set terminal title to last 2 directory levels
set_terminal_title() {
    local dir
    
    if [[ $PWD == "$HOME" || $PWD == "$HOME/" ]]; then
        dir="~"
    elif [[ $PWD == "/" ]]; then
        dir="/"
    elif [[ $PWD == "$HOME/"* ]]; then
        local rel=${PWD#$HOME/}
        local base=${rel##*/}
        if [[ $rel == */* ]]; then
            local parent=${rel%/*}; parent=${parent##*/}
            dir="~/$parent/$base"
        else
            dir="~/$base"
        fi
    else
        local base=${PWD##*/}
        if [[ $PWD == */* && ${PWD%/*} != "/" ]]; then
            local parent=${PWD%/*}; parent=${parent##*/}
            dir="$parent/$base"
        else
            dir="$base"
        fi
    fi
    
    printf '\033]0;%s\007\033]2;%s\007' "$dir" "$dir"
}

# =============================================================================
# ESSENTIAL ZSH PLUGINS
# =============================================================================

# Plugin directory
PLUGIN_DIR="$XDG_DATA_HOME/zsh/plugins"
mkdir -p "$PLUGIN_DIR"

# Function to install and load plugins
load_plugin() {
    local plugin_name=$1
    local plugin_url=$2
    local plugin_dir="$PLUGIN_DIR/$plugin_name"
    
    # Install plugin if not exists (silently)
    if [[ ! -d "$plugin_dir" ]]; then
        git clone --depth=1 --quiet "$plugin_url" "$plugin_dir" 2>/dev/null
    fi
    
    # Load plugin
    if [[ -f "$plugin_dir/$plugin_name.plugin.zsh" ]]; then
        source "$plugin_dir/$plugin_name.plugin.zsh"
    elif [[ -f "$plugin_dir/$plugin_name.zsh" ]]; then
        source "$plugin_dir/$plugin_name.zsh"
    elif [[ -f "$plugin_dir/init.zsh" ]]; then
        source "$plugin_dir/init.zsh"
    fi
}

# Essential Plugin List
# Load plugins silently

# 1. Syntax highlighting (must be loaded last among plugins)
load_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"

# 2. Autosuggestions based on history
load_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"

# 3. Better history substring search
load_plugin "zsh-history-substring-search" "https://github.com/zsh-users/zsh-history-substring-search.git"

# 4. Auto-completion enhancements
load_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions.git"

# Configure plugin settings
# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# History substring search keybindings (bind after loading)
if [[ -n "${key[Up]}" ]]; then
    bindkey "${key[Up]}" history-substring-search-up
fi
if [[ -n "${key[Down]}" ]]; then
    bindkey "${key[Down]}" history-substring-search-down
fi

# Alternative keybindings for history search
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# =============================================================================
# THIRD-PARTY TOOL INITIALIZATION
# =============================================================================

# Node Version Manager (NVM)
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# SDKMAN (Java/Kotlin/Scala version manager)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Rust environment
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Zoxide (smart directory jumping)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    # Bind Ctrl+f to zi (zoxide interactive)
    bindkey -s '^f' 'zi^M'
fi

# Starship prompt (must be at the end)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Fzf and Zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =============================================================================
# ZSH COMPLETION SYSTEM
# =============================================================================

# Initialize completion system
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Create cache directory if it doesn't exist
[[ ! -d "$XDG_CACHE_HOME/zsh" ]] && mkdir -p "$XDG_CACHE_HOME/zsh"

# =============================================================================
# STARTUP ACTIONS
# =============================================================================

# Auto-start X server on tty1 (if not already running)
if [[ -z $DISPLAY && $(tty) == "/dev/tty1" ]]; then
    exec startx
fi

# Set terminal title on prompt display
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_terminal_title

# =============================================================================
# CUSTOM KEYBINDINGS
# =============================================================================

# Enable Emacs-style keybindings
bindkey -e

# Allow Ctrl-S for forward history search (with Ctrl-R for reverse)
stty -ixon

# Enhanced keybindings
bindkey '^[[3~' delete-char                    # Delete key
bindkey '^[3;5~' delete-char                   # Ctrl+Delete
bindkey '^[[1;5C' forward-word                 # Ctrl+Right arrow
bindkey '^[[1;5D' backward-word                # Ctrl+Left arrow
bindkey '^[[5~' beginning-of-buffer-or-history # Page up
bindkey '^[[6~' end-of-buffer-or-history       # Page down
bindkey '^[[H' beginning-of-line               # Home key
bindkey '^[[F' end-of-line                     # End key

# Accept autosuggestion
bindkey '^ ' autosuggest-accept                # Ctrl+Space
bindkey '^[[Z' reverse-menu-complete           # Shift+Tab for reverse completion

# opencode
export PATH=/home/tayshaunds/.opencode/bin:$PATH
