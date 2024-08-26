#!/bin/sh

clear

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

#ZSH directory
ZDOTDIR="$HOME/.config/zsh"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

#source alias and exports
source "$ZDOTDIR/zsh-aliases"
source "$ZDOTDIR/zsh-exports"

# Add in zsh plugins
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Colors
autoload -Uz colors && colors

# Add in snippets - conflicts with aliases
#zinit snippet OMZP::git
#zinit snippet OMZP::sudo
#zinit snippet OMZP::archlinux
#zinit snippet OMZP::command-not-found
#zinit snippet OMZP::common-aliases

# Keybindings
#bindkey -e
#bindkey '^p' history-search-backward
#bindkey '^n' history-search-forward
#bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=$HOME/.cache/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# beeping is annoying
unsetopt BEEP

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#starship prompt
eval "$(starship init zsh)"

#Display fastfetch
clear
if [ "$TERM_PROGRAM" = "vscode" ]
then
   fastfetch --config neofetch.jsonc
else
   fastfetch
fi 