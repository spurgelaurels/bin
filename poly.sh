#!/bin/bash
#touch /tmp/toots
exec 1> >(logger -s -t $(basename $0)) 2>&1
export DISPLAY=:0.0
position=left



intern=eDP-1
extern=DP-1
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
  kill_poly
  MONITOR=${intern} polybar top -c ${polybar_config} &
  MONITOR=${intern} polybar bottom -c ${polybar_config} &
}


function dual()
{
  kill_poly
  MONITOR=${extern} polybar top -c ${polybar_config} &
  MONITOR=${extern} polybar bottom -c ${polybar_config} &
  }

function external()
{
  kill_poly
  echo "lid closed, external detected"
  MONITOR=${extern} polybar top -c ${polybar_config} &
  MONITOR=${extern} polybar bottom -c ${polybar_config} &
}


if xrandr | grep "$extern disconnected"; then
  echo "external disconnected, running laptop()"
  polybar_config=~/.config/polybar/config-LARGE.ini
  laptop


elif grep "closed" /proc/acpi/button/lid/LID0/state ; then
  echo "Lid closed, external assumed"
  polybar_config=~/.config/polybar/config-SMALL.ini
  external

else
  echo "configured external is not disconnected, and lid is open.  assuming both!"
  polybar_config=~/.config/polybar/config-SMALL.ini
  dual 
fi


