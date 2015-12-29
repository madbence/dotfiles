set fish_greeting

set PATH $HOME/.n/bin $PATH
set PATH $HOME/.npm/bin $PATH
set PATH $HOME/texlive/bin/x86_64-linux $PATH
set PATH /usr/bin/core_perl $PATH
set PATH $HOME/dotfiles/panel $PATH
set PATH $HOME/docker $PATH

set -x EDITOR vim

eval $HOME/dotfiles/shell.sh

if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx
  end
end
