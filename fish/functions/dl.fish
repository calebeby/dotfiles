function dl
  set url https://github.com/$argv[1]
  set path ~/Programming/github.com/$argv[1]
  if test -d $path
    echo "$argv[1] already downloaded"
  else
    mkdir -p ~/Programming
    git clone $url $path
  end
  cd $path
end
