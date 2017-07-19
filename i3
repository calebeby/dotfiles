# Use super (Windows) key
set $mod Mod4

new_window 1pixel
hide_edge_borders smart
# Font for window titles and bar
font pango:Lato, Icons 11
#font pango:DejaVu Sans Mono 8

assign [class="google-chrome-stable"] 1
exec --no-startup-id nm-applet
exec --no-startup-id i3-msg 'workspace 1; exec --no-startup-id google-chrome-stable; workspace 2; exec --no-startup-id sakura'
exec --no-startup-id dunst
exec --no-startup-id albert
exec --no-startup-id redshift

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +2% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -2% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # toggle mute

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 3 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 3 # decrease screen brightness

# start a terminal
bindsym $mod+Return exec sakura

# kill focused window
bindsym $mod+Shift+q kill

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split horizontally
bindsym $mod+b split h

# split vertically
bindsym $mod+v split v

# enter/exit fullscreen mode
bindsym $mod+f fullscreen toggle

# change container layout
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
# Taken out for menu launcher
#bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  separator_symbol " "
  status_command i3status
	position top
  colors {
    separator #928374
    background #282828
    statusline #ebdbb2
    focused_workspace #689d6a #689d6a #282828
    active_workspace #1d2021 #1d2021 #928374
    inactive_workspace #282828 #282828 #928374
    urgent_workspace #cc241d #cc241d #ebdbb2
  }
}
client.background #002B36

client.focused #689d6a #689d6a #282828 #282828
client.focused_inactive #1d2021 #1d2021 #928374 #282828
client.unfocused #32302f #32302f #928374 #282828
client.urgent #cc241d #cc241d #ebdbb2 #282828

# vi: ft=i3
