xmodmap -e "clear lock" #disable caps lock switch
xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
xset -b #disable beep

[ -f ~/.Xresources ] && xrdb ~/.Xresources

exec i3

# vim: ft=sh
