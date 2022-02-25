# fancy history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE=' *'
setopt autocd histignoredups sharehistory

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

# set up aliases
alias ag="ag $* -C --pager 'less -r'"
alias vim=nvim
alias vi=nvim
alias g="command git $*"
alias k=kubectl
alias kgp="kubectl get pods $*"
alias kaf="kubectl apply -f $*"
alias i=ibmcloud

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
  eval "$(pyenv init --path)"
fi

source <(kubectl completion zsh)

[ -s ~/dotfiles/.zshrc.local ] && source ~/dotfiles/.zshrc.local

function list-api-keys {
  op list items | jq -r '.[] | select(.overview.tags | select(. != null) | .[] | select(. == "ibmcloud-api-key") | length > 0) | .uuid'
}

ibm-login() {
  local entry=$(jq -r '.id + "," + .account + " (" + .["api-endpoint"] + " via " + .user + ")"' ~/.config/ibm-cloud-logins | fzf -d , --with-nth=2 | awk -F , '{ print $1 }')

  if ! op list items 2>&1 >/dev/null; then
    eval $(security find-generic-password -a 1password -w | op signin ibm)
  fi

  command ibmcloud login -r us-south --apikey "$(op get item $entry --fields password)" -a "$(jq -r "select(.id == \"${entry}\") | .[\"api-endpoint\"]" ~/.config/ibm-cloud-logins)"

  export IAM_TOKEN=$(command ibmcloud iam oauth-tokens | sed 's/IAM token:  //')
  touch ~/.cache/ibm-last-login
}

ibmcloud() {
  if [[ -z "$(find ~/.cache/ibm-last-login ! -mmin +15 2> /dev/null)" ]]; then
    ibm-login
  fi
  command ibmcloud "$@"
}

function set-colors {
  if [[ ! -f ~/.config/kitty/base16-$1.conf ]]; then
    curl \
      -sSL \
      -o ~/.config/kitty/base16-$1.conf \
      https://raw.githubusercontent.com/kdrag0n/base16-kitty/master/colors/base16-$1.conf
  fi
  kitty @ set-colors -a ~/.config/kitty/base16-$1.conf
  export BASE16_THEME=$1
}

function kctx {
  local context=$(kubectl config get-contexts -o name | fzf)
  kubectl config use-context $context
}

function kns {
  local ns=$(kubectl get ns -o name | awk -F / '{print $2}' | fzf)
  kubectl config set-context --current --namespace $ns
}

export PATH="/Applications/kitty.app/Contents/MacOS/:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export VOLTA_HOME="$HOME/.volta"
export PATH="$HOME/.daml/bin:$VOLTA_HOME/bin:$PATH"
[ -f "/Users/lennon/.ghcup/env" ] && source "/Users/lennon/.ghcup/env" # ghcup-env
