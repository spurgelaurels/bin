#!/bin/bash

exec 1> >(logger -s -t $(basename $0)) 2>&1
export DISPLAY=:0.0
position=left

# This is used to determine which external display you have connected
if [ `xrandr | grep HDMI-1 | grep -c ' connected '` -eq 1 ]; then
        extern="HDMI-1"
fi
if [ `xrandr | grep HDMI-2 | grep -c ' connected '` -eq 1 ]; then
        extern="HDMI-2"
fi
if [ `xrandr | grep DP1 | grep -c ' connected '` -eq 1 ]; then
        extern="DP-1"
fi
if [ `xrandr | grep DP-2 | grep -c ' connected '` -eq 1 ]; then
        extern="DP-2"
fi

intern=eDP-1

function dual()
{
  xrandr --output "$intern" --primary --auto
  xrandr --output "$extern" --"$position"-of "$intern" --auto
}

function external()
{
  echo "lid closed, external detected"
  xrandr --output "$extern" --primary --auto
  xrandr --output "$intern" --off
}


if xrandr | grep "$extern disconnected"; then
  echo "external disconnected, running laptop()"
  laptop


elif grep "closed" /proc/acpi/button/lid/LID/state ; then
  echo "Lid closed, external assumed"
  external

else
  echo "configured external is not disconnected, and lid is open.  assuming both!"
  dual 
fi







