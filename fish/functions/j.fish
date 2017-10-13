function j
  set -l dir (ls -d ~/Programming/*/*/* | sed 's/\/home\/caleb\/Programming\///' | fzf --preview "tree -C $HOME/Programming/{}")
  cd "$HOME/Programming/$dir"
end
