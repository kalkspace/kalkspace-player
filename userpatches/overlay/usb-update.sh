#!/bin/bash

VIDEO=(kalkspace-player/video.*)

RESTART=0
if [[ -f ${VIDEO[0]} ]]; then
	cp ${VIDEO[0]} $HOME/kalkspace-player/
	VIDEO_BASENAME=$(basename ${VIDEO[0]})
	ln -nsf $VIDEO_BASENAME $HOME/kalkspace-player/video
	RESTART=1
fi

if [[ -f kalkspace-player/cage-options ]]; then
	cp kalkspace-player/cage-options /home/kalkspace-player/kalkspace-player/cage-options
	RESTART=1
fi

if [[ -f kalkspace-player/mpv-options ]]; then
	cp kalkspace-player/mpv-options /home/kalkspace-player/kalkspace-player/mpv-options
	RESTART=1
fi

if [[ "$RESTART" -eq "1" ]]; then
	sync
	killall cage
fi
