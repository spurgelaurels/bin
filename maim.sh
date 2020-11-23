#!/bin/bash
# Wrapper to maim for storing screenshots by date/time
maim -s ~/Pictures/screenshots/$(date +%F-%T).png
