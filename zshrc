#
# User configuration sourced by interactive shells
#

# Source zim
# if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
#   source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
# fi

export EDITOR='nvim'
export BROWSER='google-chrome-stable'

# export PGDATA='/var/lib/postgres/data'

# Disable beep
xset -b

autoload zmv

alias git='hub'
alias gaa='git add -A'
alias p="bashpodder && ~/Podcasts/speedup.sh"
alias t="~/Podcasts/transfer.sh"
# alias cat='fun () {highlight -O ansi -i $1 2>/dev/null || command cat $1;}; fun'
alias apt-get="sudo apt-get"
alias dotbot='~/dotfiles/install -d ~/dotfiles/'
alias cp='cp --verbose'
alias rerun='~/dotfiles/rerun'
alias ls='ls -v --color=tty'
alias busy="cat /dev/urandom | hexdump -C | ag --color 'ce e'"
alias mm='bundle exec middleman'
alias gs='hub status'
alias e='if [ -s Session.vim ] ; then; nvim -S; else; nvim; fi'
alias b='halt -p'
alias ag='ag --path-to-ignore ~/.agignore --hidden'
alias work='tmux attach -t'
alias install='yaourt -S'
alias uninstall='yaourt -Rs'
alias remove='yaourt -Rs'
alias coala='coala -n'
alias open='xdg-open'
alias update='sudo echo; yaourt -Syu --aur'
alias mmv='noglob zmv -W'
alias pullall='~/dotfiles/pullall.sh'
alias commitstats='git log --format=format:%s%b | tr "[:upper:]" "[:lower:]" | tr -c "[:alnum:]" "[\n*]" | sort | uniq -c | sort -nr | head -25'
alias glog='gl'
alias gl='git pull'

j() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
alias nuke='jst-nuke'
alias n='nvim $(fzf)'

export PATH="$PATH:$HOME/.rvm/bin:/usr/local/bin"

export PATH="$PATH:$HOME/.local/bin"

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE='gtk'

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH="$PATH:$GOBIN"

export NPM_CONFIG_PREFIX=~/.npm-global
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.yarn-global/bin:$PATH
export PREFIX=~/.yarn-global

# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# source $HOME/.cargo/env

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

autoload -U compinit; compinit

zmodload -i zsh/complist
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format '%F{blue}--%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'
zstyle ':completion:*' squeeze-slashes true

# enable caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-${HOME}}/.zcompcache"

# ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# completion sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# smart editor completion
zstyle ':completion:*:(nano|vim|nvim|vi|emacs|e):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|webm|iso|dmg|so|o|a|bin|exe|dll|pcap|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|mobi|epub|png|jpeg|jpg|gif)'
