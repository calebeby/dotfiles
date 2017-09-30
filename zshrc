export EDITOR='nvim'
export BROWSER='google-chrome-stable'

# Disable beep
xset -b

autoload zmv

fpath=("$HOME/.zfunctions" $fpath)
fpath=("$HOME/dotfiles/completion" $fpath)
export PATH=~/dotfiles/scripts:$PATH

which hub > /dev/null && alias git='hub'
alias gs='git status'
alias gc='git commit --verbose'
alias gaa='git add -A'
alias gp='git push'
alias gl='git pull'
alias gcl='git clone'

alias p="bashpodder && ~/Podcasts/speedup.sh"
alias t="~/Podcasts/transfer.sh"

alias pacman="sudo bb-wrapper --aur"
alias install="pacman -S"
alias uninstall="pacman -Rs"
alias update="pacman -Syu"
alias ls='ls -v --color=tty'
alias e='if [ -s Session.vim ] ; then; nvim -S; else; nvim; fi'
alias b='halt -p'
alias mmv='noglob zmv -W'

colorscheme gruvbox-dark-medium

export PATH="$PATH:$HOME/.local/bin"

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH="$PATH:$GOBIN"

export NPM_CONFIG_PREFIX=~/.npm-global
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.yarn-global/bin:$PATH
export PREFIX=~/.yarn-global

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
which rg > /dev/null && export FZF_DEFAULT_COMMAND='rg --files --hidden --follow 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
  --color fg:7,bg:0,hl:6,fg+:7,bg+:0,hl+:6
  --color info:240,prompt:4,pointer:1,marker:5,spinner:2,header:4
  --preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -50"
'

which fasd > /dev/null && eval "$(fasd --init auto)"

fd() {
  local DIR
  DIR=$(d -l | sed '/\/\./ d' | fzf +s +m --tac --preview "itree --noreport --filelimit 20 -C -L 3 {} | head -n $(tput lines)") && cd $DIR
}

autoload -U promptinit; promptinit
prompt pure

# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi

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
