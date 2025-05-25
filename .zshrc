# Aliases

alias ls="ls --color"


# Keybindings

bindkey "^k" history-search-backward
bindkey "^j" history-search-forward


# Variables.

# XDG Specific Variables.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# Shell Related.
export EDITOR="hx"
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# History Related Variables.
export HISTSIZE=2500
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export HISTDUP="erase"

# Homebrew Related Variables.
export HOMEBREW_NO_ENV_HINTS="true"

# Readline Related Variables.
export CPPFLAGS="-I/opt/homebrew/opt/readline/include"
export LDFLAGS="-L/opt/homebrew/opt/readline/lib"

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


# Runnables

# Download Zinit if doesn't exist in the system.
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$ZINIT_HOME"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Sourcing Zinit.
source "$ZINIT_HOME/zinit.zsh"

# Enabling Typewritten Theme.
zinit ice compile'(typewritten|async).zsh' pick'async.zsh' src'typewritten.zsh'
zinit light reobin/typewritten

# Enabling Zinit Plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

# Show hidden files in fzf-tab completions.
setopt globdots

# Append the commands to history file, rather than overwriting it.
setopt appendhistory

# Share the history between different terminal sessions.
setopt sharehistory

# Ignore appending the commands into history if it's prefixed by a space.
setopt hist_ignore_space

# Ignore duplicates in the history.
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Case-Insensitive Auto Completion.
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"

# Enabling Colors for the Completions.
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

# Disabling the default ZStyle Completion menu.
zstyle ":completion:*" menu no

# Better cd autocomplete using fzf-tab.
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'ls --color $realpath'

# Enabling Mise Shims.
eval "$(mise activate zsh)"

# Enabling FZF Shell Integration.
eval "$(fzf --zsh)"

# Load the completions before starting.
autoload -U compinit && compinit
zinit cdreplay -q

# Nice System Information on Session Load.
fastfetch
