set -x EDITOR 'nvim'
set -x BROWSER 'chromium-browser'
# set -x JAVA_HOME /usr/lib/jvm/jre-11
# set -x JAVA_HOME /usr/lib/jvm/java-openjdk
set -x JAVA_HOME /usr/lib/jvm/java-11-openjdk
set -x QT_QPA_PLATFORMTHEME qt5ct

set -x GOPATH $HOME/Programming
set -x QT_QPA_PLATFORM xcb

set -x PATH $PATH ~/.npm-global/bin /home/caleb/.cargo/bin /home/linuxbrew/.linuxbrew/bin $GOPATH/bin

set -x MOZ_USE_XINPUT2 1

if type -q hub
  alias git='hub'
end

abbr ns npm start
# alias code code-insiders
abbr nd npm run dev
abbr ni npm install
abbr nt npm test
abbr ntw npm run test:watch
abbr ny npm type
abbr nyw npm run type:watch

abbr y yarn
abbr ys yarn start
abbr yt yarn test
abbr ytw yarn test --watch

abbr gs git status
abbr gc git commit --verbose
abbr gca git commit --verbose --all
abbr gaa git add -A
abbr gp git push
abbr gl git pull
abbr gcl git clone

alias p="bashpodder; and ~/Podcasts/speedup.sh"
alias t="~/Podcasts/transfer.sh"

alias install="sudo dnf install"
alias uninstall="sudo dnf remove"
alias update="sudo dnf update"
alias ls='ls -v --color=tty'
alias b='systemctl poweroff'

if type -q rg
  set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow 2>/dev/null'
end

set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# set -x FZF_DEFAULT_OPTS '--color fg:7,bg:0,hl:6,fg+:7,bg+:0,hl+:6,info:240,prompt:4,pointer:1,marker:5,spinner:2,header:4 --preview "cat {}  | head -50"'
if type -q bat
  set -x FZF_DEFAULT_OPTS '--preview "bat {} --color always --paging never --style plain"'
else
  set -x FZF_DEFAULT_OPTS '--preview "cat {}'
end

set fish_greeting ""

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
  end
end

function __check_nvm --on-variable PWD --description 'Check node version'
  status --is-command-substitution; and return
  if [ -e ".nvmrc" ]
    nvm
  end
end

# fish_vi_key_bindings insert
# set fish_cursor_default block
# set fish_cursor_insert line
# set fish_cursor_replace_one underscore
# set fish_cursor_visual block
