#!/bin/bash
#touch /tmp/toots
exec 1> >(logger -s -t $(basename $0)) 2>&1
export DISPLAY=:0.0
position=left

# This is used to determine which external display you have connected
# This may vary between OS. e.g VGA1 instead of VGA-1
if [ `xrandr | grep VGA-1 | grep -c ' connected '` -eq 1 ]; then
        extern="VGA-1"
fi
if [ `xrandr | grep DVI-1 | grep -c ' connected '` -eq 1 ]; then
        extern="DVI-1"
fi
if [ `xrandr | grep HDMI-1 | grep -c ' connected '` -eq 1 ]; then
        extern="HDMI-1"
fi
if [ `xrandr | grep HDMI-2 | grep -c ' connected '` -eq 1 ]; then
        extern="HDMI-2"
fi
if [ `xrandr | grep HDMI-3 | grep -c ' connected '` -eq 1 ]; then
        extern="HDMI-3"
fi
if [ `xrandr | grep DP1 | grep -c ' connected '` -eq 1 ]; then
        extern="DP-1"
fi
if [ `xrandr | grep DP-2 | grep -c ' connected '` -eq 1 ]; then
        extern="DP-2"
fi
if [ `xrandr | grep DP-3 | grep -c ' connected '` -eq 1 ]; then
        extern="DP-3"
fi

intern=eDP-1
#extern=`xrandr --listmonitors | grep "^ 1" | awk '{print $4}'`


#extern=HDMI-2

function kill_poly()
{
  # Terminate already running bar instances
  killall  polybar

  # Wait until the processes have been shut down
  while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
}

function laptop()
{
#  kill_poly
  xrandr --output "$extern" --off --output "$intern" --auto
#  MONITOR=${intern} polybar top -c ${polybar_config} &
#  MONITOR=${intern} polybar bottom -c ${polybar_config} &
}


function dual()
{
#  kill_poly
  xrandr --output "$intern" --primary --auto
  xrandr --output "$extern" --"$position"-of "$intern" --auto
#  MONITOR=${extern} polybar top -c ${polybar_config} &
#  MONITOR=${extern} polybar bottom -c ${polybar_config} &
  }

function external()
{
#  kill_poly
  echo "lid closed, external detected"
  xrandr --output "$extern" --primary --auto
  xrandr --output "$intern" --off
#  MONITOR=${extern} polybar top -c ${polybar_config} &
#  MONITOR=${extern} polybar bottom -c ${polybar_config} &
}


if xrandr | grep "$extern disconnected"; then
  echo "external disconnected, running laptop()"
#  polybar_config=~/.config/polybar/config-LARGE.ini
  laptop


elif grep "closed" /proc/acpi/button/lid/LID/state ; then
  echo "Lid closed, external assumed"
#  polybar_config=~/.config/polybar/config-SMALL.ini
  external

else
  echo "configured external is not disconnected, and lid is open.  assuming both!"
#  polybar_config=~/.config/polybar/config-SMALL.ini
  dual 
fi







