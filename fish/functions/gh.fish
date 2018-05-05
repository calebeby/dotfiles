function gh
  set -l path (string replace -r "$HOME/Programming/src" '' (pwd))
  open "https://$path"
end
