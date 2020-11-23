#!/bin/bash

# Run powersaving script
case $1 in
  battery)
    echo "Running powersaving on battery"

    # Enable suspend on lid closing
    sed -i 's/HandleLidSwitch=ignore/HandleLidSwitch=suspend/' /etc/systemd/logind.conf
  ;;
  AC)
    echo "Running powersaving on AC"
    
    # Disable suspend on lid closing
    sed -i 's/HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
  ;;
esac
