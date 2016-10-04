# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/picard/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey "^[[3~" delete-char
bindkey "^[[8~" end-of-line
bindkey "^[[7~" beginning-of-line

fpath=("$HOME/.zfunctions" $fpath)

source ~/.zsh/git.zsh
source ~/scripts/base16-ocean.dark.sh
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh
AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1

zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init

autoload -U promptinit && promptinit
prompt pure

export NVM_DIR="/home/picard/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

zstyle ':completion:*' menu select=2

export PATH=~/texlive/bin/x86_64-linux:$PATH
export PATH=~/scripts:$PATH
