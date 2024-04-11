#!/bin/bash

sketchybar --set "$NAME" label="$(curl -H "Accept: text/plain" https://icanhazdadjoke.com)"

