function j
  set -l dir (ls -d ~/Programming/src/*/*/* | sed 's/\/home\/caleb\/Programming\/src\///' | fzf --preview "tree -C $HOME/Programming/src/{} -I 'node_modules|__pycache__'")
  cd "$HOME/Programming/src/$dir"
  clear
end
