xmodmap -e "clear lock" #disable caps lock switch
xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
# setxkbmap -option ctrl:nocaps
# xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'

xset -b #disable beep

[ -f ~/.Xresources ] && xrdb ~/.Xresources

exec i3

# vim: ft=sh
