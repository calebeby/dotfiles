set -x EDITOR 'nvim'
set -x BROWSER 'google-chrome-stable'

set -x PREFIX $HOME/.yarn-global

set -x PATH $HOME/.config/yarn/global/node_modules/.bin $HOME/.local/bin $PATH

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

if type -q rg
  set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow 2>/dev/null'
end

set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_DEFAULT_OPTS '--color fg:7,bg:0,hl:6,fg+:7,bg+:0,hl+:6,info:240,prompt:4,pointer:1,marker:5,spinner:2,header:4 --preview "cat {}  | head -50"'

set fish_greeting ""

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
  end
end

# fish_vi_key_bindings
# set fish_bind_mode insert
# function fish_mode_prompt; end
# set fish_cursor_default block
# set fish_cursor_insert line
# set fish_cursor_visual block
