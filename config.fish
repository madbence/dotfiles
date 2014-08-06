function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l arrow "λ"
  set -l cwd $blue(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set git_info $green(_git_branch_name)
    set git_info ":$git_info"

    if [ (_is_git_dirty) ]
      set -l dirty "*"
      set git_info "$git_info$dirty"
    end
  end

  echo -n -s $cwd $git_info $normal ' ' $arrow ' '
end

set PATH $HOME/.n/bin $PATH
set PATH $HOME/.npm/bin $PATH
set PATH $HOME/.texlive/2014/bin/x86_64-linux $PATH

set -x EDITOR vim

if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx
  end
end
