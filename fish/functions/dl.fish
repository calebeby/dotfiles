function dl
  set path (string replace -r "https?://" '' "$argv[1]" | tr '[:upper:]' '[:lower:]')
  # if not a url
  if not string match -r '[-A-Za-z0-9]*\.[A-Za-z]*' $path
    # if not user/repo
    if not string match -r '.*/.*' $path
      set path "calebeby/$path"
    end
    set path "github.com/$path"
  end
  set folder "$HOME/Programming/$path"
  set url "https://$path"
  if test -d $folder
    echo "$url already downloaded"
  else
    mkdir -p $folder
    git clone $url $folder
  end
  cd $folder
end
