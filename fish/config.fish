set -x EDITOR nvim
set -x VISUAL nvim
set -x BROWSER firefox
# set -x JAVA_HOME /usr/lib/jvm/jre-11
# set -x JAVA_HOME /usr/lib/jvm/java-openjdk
set -x JAVA_HOME /usr/lib/jvm/java-11-openjdk
set -x QT_QPA_PLATFORMTHEME qt5ct

set -x GOPATH $HOME/Programming
set -x QT_QPA_PLATFORM xcb

set -x PATH $PATH ~/.local/bin ~/.npm-global/bin $HOME/.cargo/bin /home/linuxbrew/.linuxbrew/bin $GOPATH/bin

set -x DENO_INSTALL /home/caleb/.deno
set -x PATH $PATH $DENO_INSTALL/bin

set -x MOZ_USE_XINPUT2 1

set --global hydro_fetch false
set --global hydro_color_prompt magenta
set --global hydro_color_duration yellow
set --global hydro_color_pwd blue
set --global hydro_color_git brblack

set --global hydro_symbol_prompt "\n❯"
set --global hydro_symbol_git_dirty "*"

set --global hydro_symbol_git_behind "⇣"
set --global hydro_symbol_git_ahead "⇡"

alias n="nvim -S"
alias nn="nvim"

abbr ns npm start
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

alias install="sudo dnf install"
alias uninstall="sudo dnf remove"
alias update="sudo dnf update"
alias b='systemctl poweroff'

if type -q rg
    set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow 2>/dev/null'
end

set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
if type -q bat
    set -x FZF_DEFAULT_OPTS '--preview "bat {} --color always --paging never --style plain"'
else
    set -x FZF_DEFAULT_OPTS '--preview "cat {}'
end

set fish_greeting ""
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME

# Bun
set -Ux BUN_INSTALL ~/.bun
set -px --path PATH ~/.bun/bin

# pnpm
set -gx PNPM_HOME "/home/caleb/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/caleb/.ghcup/bin $PATH # ghcup-env
