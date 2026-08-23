# ---------------------------------------------------------------------
# SETUP
# ---------------------------------------------------------------------

# Aliases

# Replacements
alias cat="bat"
alias ls="lsd"

# Tools
alias lg="lazygit"
alias pi="omp"
alias yz="yazi"

# Quick Commands
alias :c="clear"
alias :q="exit"
alias :z="source ~/.zshrc"

# Keybindings
bindkey -v
bindkey "^k" history-search-backward
bindkey "^j" history-search-forward


# Variables

# XDG Specific Variables.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# Shell Related Variables.
export CLICOLOR=1
export EDITOR="hx"

# FZF Related Variables.
FZF_COLORS=(
  '--color=bg:-1,bg+:#313244,spinner:#f5e0dc,hl:#f38ba8'
  '--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc'
  '--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
)
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --exact"
export FZF_DEFAULT_OPTS="${FZF_COLORS[*]}"


# History Related Variables.
export HISTSIZE=2500
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export HISTDUP="erase"

# Homebrew Related Variables.
export HOMEBREW_NO_ENV_HINTS="true"
export HOMEBREW_PREFIX="/opt/homebrew"

# PkgConfig Related Variables.
lib_path="$HOMEBREW_PREFIX/opt"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/bin/pkg-config:$lib_path/icu4c/lib/pkgconfig:$lib_path/curl/lib/pkgconfig:$lib_path/zlib/lib/pkgconfig"

# Ruby related Variables.
export RUBY_YJIT_ENABLE="true"

# SDKROOT setup
export SDKROOT=$(xcrun --show-sdk-path)

# Typewritten Theme Related Variables.
export TYPEWRITTEN_ARROW_SYMBOL="=>"
export TYPEWRITTEN_CURSOR="terminal"
export TYPEWRITTEN_RELATIVE_PATH="home"
export TYPEWRITTEN_SYMBOL="->"

# Zinit Related Variables.
export ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"

export PATH="/Library/Developer/CommandLineTools/usr/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.bun/bin:$PATH"

# Download Zinit if doesn't exist in the system.
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$ZINIT_HOME"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Sourcing Zinit.
source "$ZINIT_HOME/zinit.zsh"

# ---------------------------------------------------------------------
# PLUGINS & THEME
# ---------------------------------------------------------------------

# Load the prompt instantly
zinit ice compile'(typewritten|async).zsh' pick'async.zsh' src'typewritten.zsh'
zinit light reobin/typewritten

# Load Plugins
zinit ice wait lucid bindings completions
zinit light Aloxaf/fzf-tab

# Load fzf default keybindings (CTRL+R for history, CTRL+T for files, ALT+C for directories)
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C" atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C" atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# ---------------------------------------------------------------------
# SHELL OPTIONS & STYLES
# ---------------------------------------------------------------------
setopt auto_cd
setopt globdots
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Use Completion Cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"

# Interactive Completion Menu
zstyle ':completion:*' menu select

# Completion Grouping
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'

# Descriptions and stuff
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' default-description default
zstyle ':completion:*:*' format '[%d]'
zstyle ':completion:*:corrections' format '[%d (errors: %e)]'
zstyle ':completion:*:warnings' format '[no matches found]'

# Control groups in fzf-tab
zstyle ':fzf-tab:*' switch-group '<' '>'

# Catppuccin Mocha (Transparent) for fzf-tab
zstyle ':fzf-tab:*' fzf-flags "${FZF_COLORS[@]}" '--border=rounded' '--layout=reverse'

# Better completions for cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always -1 $realpath'

# Better completions for cat
zstyle ':fzf-tab:complete:(cat|bat|nano|vim|nvim|hx):*' fzf-preview \
  'bat --color=always --style=numbers,changes --line-range=:500 $realpath'

# ---------------------------------------------------------------------
# EXTERNAL TOOLS & COMPLETIONS
# ---------------------------------------------------------------------

# Activate Mise
zinit ice wait lucid
zinit snippet OMZP::mise

# Compile autocompletions dump
autoload -Uz compinit;
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
  compinit
else
  compinit -C
fi

# Tell Zinit to catch up on completions in the background
zinit cdreplay -q

# Automatically precompile .zshrc to bytecode if it changed
if [[ -s "$HOME/.zshrc" && (! -s "$HOME/.zshrc.zwc" || "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc") ]]; then
  zcompile "$HOME/.zshrc"
fi
