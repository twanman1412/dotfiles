# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Directory navigation options
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Completion system
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
compinit -d "$HOME/.cache/zcompdump-$ZSH_VERSION"

# Modern CLI replacement aliases
if command -v eza &>/dev/null; then
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -la --icons=auto --group-directories-first --git'
    alias tree='eza --tree --icons=auto'
fi

if command -v bat &>/dev/null; then
    alias cat='bat --paging=never --style=plain'
fi

# Zoxide (smarter cd) initialization
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# FZF integration (default arch path)
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# Source fast plugins (Arch pacman paths)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

[ -f "$HOME/.cache/theme-env" ] && source "$HOME/.cache/theme-env"

# Initialize Starship prompt
eval "$(starship init zsh)"
