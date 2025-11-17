function j
  set -l dir (ls -d ~/Programming/*/* | sed 's/\/home\/caleb\/Programming\\///' | tv --preview-command "tree -C $HOME/Programming/{} -I 'node_modules|__pycache__|dist'")
  cd "$HOME/Programming/$dir"
  clear
end
