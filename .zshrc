# fancy history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE=' *'
setopt appendhistory autocd histignoredups

# disable annoying sounds
unsetopt beep

# emacs key bindings
bindkey -e

# source a few stuffz
fpath=("$HOME/.zfunctions" $fpath)
source ~/.zsh/git.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/gruvbox.sh

zstyle :compinstall filename "~/.zshrc"
zstyle ':completion:*' menu select=2
autoload -Uz compinit promptinit
compinit
promptinit
prompt pure

# fix delete button
bindkey "^[[3~" delete-char

# fix default editor
export EDITOR=nvim
export VISUAL=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

alias ag="ag $* -C --pager 'less -r'"
alias vim=nvim
alias vi=nvim

typeset -U path
export PATH="$PATH:$HOME/.rvm/bin"
