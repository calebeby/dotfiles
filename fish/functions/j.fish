function j
  set -l dir (ls -d ~/Programming/*/* | sed 's/\/home\/caleb\/Programming\\///' | fzf --preview "tree -C $HOME/Programming/{} -I 'node_modules|__pycache__|dist'")
  cd "$HOME/Programming/$dir"
  clear
end
