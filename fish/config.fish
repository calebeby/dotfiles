set -x EDITOR 'nvim'
set -x BROWSER 'google-chrome-stable'

set -x GOPATH ~/go
set -x GOBIN $GOPATH/bin

set -x NPM_CONFIG_PREFIX ~/.npm-global
set -x PREFIX $HOME/.yarn-global
set -x N_PREFIX $HOME/.n

set -x PATH $HOME/.gem/ruby/2.4.0/bin $HOME/.config/yarn/global/node_modules/.bin $HOME/.n/bin $HOME/.local/bin $HOME/.npm-global/bin $GOBIN $PATH

# Disable beep
xset -b

if type -q hub
  alias git='hub'
end

alias gs='git status'
alias gc='git commit --verbose'
alias gaa='git add -A'
alias gp='git push'
alias gl='git pull'
alias gcl='git clone'

alias p="bashpodder; and ~/Podcasts/speedup.sh"
alias t="~/Podcasts/transfer.sh"

alias pacman="sudo bb-wrapper --aur"
alias install="pacman -S"
alias uninstall="pacman -Rs"
alias update="pacman -Syu"
alias ls='ls -v --color=tty'
alias b='halt -p'
alias mmv='noglob zmv -W'

function e
  if [ -s Session.vim ]
    nvim -S
  else
    nvim
  end
end

if type -q rg
  set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow 2>/dev/null'
end

set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_DEFAULT_OPTS '--color fg:7,bg:0,hl:6,fg+:7,bg+:0,hl+:6,info:240,prompt:4,pointer:1,marker:5,spinner:2,header:4 --preview "cat {}  | head -50"'

set fish_greeting ""

# function fd
#   local DIR
#   DIR=$(d -l | sed '/\/\./ d' | fzf +s +m --tac --preview "itree --noreport --filelimit 20 -C -L 3 {} | head -n $(tput lines)"); and cd $DIR
# end
