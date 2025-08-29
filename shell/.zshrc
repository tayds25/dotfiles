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
# export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

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

# FZF default options with Everforest Dark Hard theme (matching WezTerm)
export FZF_DEFAULT_OPTS="--ansi --height 80% --layout=reverse --border \
--color=fg:#d3c6aa,bg:-1,hl:#a7c080 \
--color=fg+:#d3c6aa,bg+:#464e53,hl+:#a7c080 \
--color=info:#dbbc7f,prompt:#a7c080,pointer:#E69875 \
--color=marker:#83c092,spinner:#7fbbb3,header:#7fbbb3 \
--color=border:#868d80,gutter:-1"

# =============================================================================
# LOAD ALIASES AND FUNCTIONS
# =============================================================================

# Source aliases and functions from separate file
[[ -f "$HOME/dotfiles/shell/.zsh_aliases" ]] && source "$HOME/dotfiles/shell/.zsh_aliases"

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

# 1.  Auto-completion enhancements
load_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions.git"

# 2. Autosuggestions based on history
load_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"

# 3. Fuzzy completion
load_plugin "fzf-tab" "https://github.com/Aloxaf/fzf-tab.git"

# 4. Better history substring search
load_plugin "zsh-history-substring-search" "https://github.com/zsh-users/zsh-history-substring-search.git"

# 5. Alias reminder plugin
load_plugin "zsh-you-should-use" "https://github.com/MichaelAquilina/zsh-you-should-use.git"

# 6. Syntax highlighting (must be loaded last among plugins)
load_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"


# Configure plugin settings

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# You Should Use plugin configuration
export YSU_MESSAGE_POSITION="after"
export YSU_MESSAGE_FORMAT="$(tput setaf 1)Hey! You have an alias for that: $(tput bold;tput setaf 3)%alias$(tput sgr0)"

# Ensure colors match using FZF_DEFAULT_OPTS
zstyle ":fzf-tab:*" use-fzf-default-opts yes

# Preview file contents when tab completing directories.
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color=always \${realpath}"


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
[ -f ~/dotfiles/shell/.fzf.zsh ] && source ~/dotfiles/shell/.fzf.zsh


# =============================================================================
# ZSH COMPLETION SYSTEM
# =============================================================================

# Initialize completion system
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Create cache directory if it doesn't exist
[[ ! -d "$XDG_CACHE_HOME/zsh" ]] && mkdir -p "$XDG_CACHE_HOME/zsh"

# Fzf integration
source <(fzf --zsh)

# Save fzf history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

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
