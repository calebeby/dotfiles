function vsnew
  aria2c --allow-overwrite "https://go.microsoft.com/fwlink/?LinkID=760866" -o /tmp/code-insiders.rpm -d /
  sudo dnf install /tmp/code-insiders.rpm
end
