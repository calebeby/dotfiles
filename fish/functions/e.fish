function e
  if [ -s Session.vim ]
    nvim -S
  else
    nvim
  end
end
