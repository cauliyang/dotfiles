#!/usr/bin/env sh
#
sketchybar --add item battery right \
	--set battery update_freq=30 \
	script="$PLUGIN_DIR/power.sh" \
	--subscribe battery system_woke
