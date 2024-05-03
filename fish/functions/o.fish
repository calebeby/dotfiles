function o
    cd $HOME/Documents/MIT_Notes/
    set -l dir (fd --type directory | fzf --preview "tree -C {} -I 'node_modules|__pycache__|dist'")
    cd "$HOME/Documents/MIT_Notes/$dir"
    clear
end
