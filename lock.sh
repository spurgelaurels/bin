#!/bin/bash
# Blur the lock screen and troll your friends 

ICON=$HOME/Pictures/icon.png
TMPBG=/tmp/screen.png
rm /tmp/screen.png
scrot /tmp/screen.png
convert $TMPBG -scale 5% -scale 2000% $TMPBG
#convert $TMPBG -scale 10% -scale 1000% $TMPBG
#convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -u -i $TMPBG
