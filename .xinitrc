#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Numlock
numlockx on &

# Compositor
~/.config/bspwm/startup.sh

# Policy kit
lxsession &

# Swap esc and caps
# setxkbmap -option caps:swapescape

# disk mounter
udiskie &

# Wallpaper
nitrogen --restore &

# Export GTK_PATH
GTK_PATH="$GTK_PATH:/usr/lib/gtk-2.0"
export GTK_PATH

# Execute bspwm
exec bspwm
