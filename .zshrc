# ---------------------------------------------------------------------
# SETUP
# ---------------------------------------------------------------------

# Aliases
alias lg="lazygit"
alias yz="yazi"
alias pi="omp"

# Keybindings

bindkey "^k" history-search-backward
bindkey "^j" history-search-forward


# Variables

# XDG Specific Variables.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# Shell Related.
export CLICOLOR=1
export EDITOR="hx"

# History Related Variables.
export HISTSIZE=2500
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export HISTDUP="erase"

# Homebrew Related Variables.
export HOMEBREW_NO_ENV_HINTS="true"
export HOMEBREW_PREFIX="/opt/homebrew"

# Mise Related Variables.
export MISE_RUBY_BUILD_OPTS="--enable-yjit"

# Ruby Related Variables.
export RUBY_YJIT_ENABLE="true"

# Typewritten Theme Related Variables.
export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_RELATIVE_PATH="home"
export TYPEWRITTEN_SYMBOL="->"

# Zinit Related Variables.
export ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"

export PATH="/Library/Developer/CommandLineTools/usr/bin:$HOME/bin:$HOME/.local/bin:$HOME/.bun/bin:/usr/local/bin:$PATH"

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

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C" atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C" atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

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

zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color \$realpath"

# ---------------------------------------------------------------------
# EXTERNAL TOOLS & COMPLETION FIXED
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

# System Information
if [[ -o interactive ]]; then
    fastfetch
fi

# Automatically precompile .zshrc to bytecode if it changed
if [[ -s "$HOME/.zshrc" && (! -s "$HOME/.zshrc.zwc" || "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc") ]]; then
  zcompile "$HOME/.zshrc"
fi
