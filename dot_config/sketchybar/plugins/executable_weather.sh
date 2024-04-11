#!/bin/bash

#https://github.com/chubin/wttr.in

sketchybar --set "$NAME" label="$(curl wttr.in/\?format="%C+%t\n")"
# sketchybar --set "$NAME" label="$(curl wttr.in/\?format="%c%t\n")"
