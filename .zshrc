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

# black magic
fpath=("$HOME/.zfunctions" $fpath)
zstyle :compinstall filename "~/.zshrc"
zstyle ':completion:*' menu select=2
autoload -Uz compinit promptinit bashcompinit
compinit
promptinit
bashcompinit
prompt pure

# source da pluginz
source ~/.prezi/simply/simply.completion
# source ~/dotfiles/base16-gruvbox-dark-soft.sh
source ~/dotfiles/base16-grayscale-light.sh
source ~/.zsh/git.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# setup syntax highlight
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'

# fix delete button
bindkey "^[[3~" delete-char

# fix default editor
export EDITOR=nvim
export VISUAL=nvim

# set up nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# set up aliases
alias ag="ag $* -C --pager 'less -r'"
alias vim=nvim
alias vi=nvim

function cdp() {
  cd ~/.prezi/$1
  source virtualenv/bin/activate
}

# update env vars
typeset -U path
path+=$HOME/.bin
path+=$HOME/.rvm/bin
path+=$HOME/.pyenv/bin
path+=$HOME/.cargo/bin
path+=$HOME/.local/bin
path+=/usr/local/bin
export PATH
export LANG="en_US.UTF-8"

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -s ~/dotfiles/.zshrc.local ] && source ~/dotfiles/.zshrc.local
