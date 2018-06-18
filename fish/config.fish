set -x EDITOR 'nvim'
set -x BROWSER 'chromium'
set -x JAVA_HOME /usr/lib/jvm/java-8-jdk
set -x QT_QPA_PLATFORMTHEME qt5ct

set -x PATH $PATH ~/.yarn/bin /home/caleb/.cargo/bin

set -x MOZ_USE_XINPUT2 1

set -x GOPATH $HOME/Programming

if type -q hub
  alias git='hub'
end

abbr ns npm start
abbr ni npm install
abbr nt npm test
abbr ntw npm run test:watch

abbr y yarn
abbr ys yarn start
abbr yt yarn test
abbr ytw yarn test:watch

abbr gs git status
abbr gc git commit --verbose
abbr gaa git add -A
abbr gp git push
abbr gl git pull
abbr gcl git clone

alias p="bashpodder; and ~/Podcasts/speedup.sh"
alias t="~/Podcasts/transfer.sh"

alias pacman="bb-wrapper --aur"
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
source ~/.asdf/asdf.fish
