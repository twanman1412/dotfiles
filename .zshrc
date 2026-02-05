
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/twan/.zshrc'

autoload -Uz compinit 
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

autoload -Uz promptinit
promptinit

prompt_mytheme_setup() {
	PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f > '
	RPROMPT='[%F{yellow}%?%f]'
}

prompt_themes+=( mytheme )

prompt mytheme

alias zen='flatpak run app.zen_browser.zen'
alias bitwarden='flatpak run com.bitwarden.desktop'
alias spotify='flatpak run com.spotify.Client'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR='nvim'

source /usr/share/nvm/init-nvm.sh
