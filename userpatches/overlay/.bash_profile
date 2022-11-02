if [[ $(tty) == "/dev/tty1" ]]; then
        while [ true ]; do
                cage $(cat kalkspace-player/cage-options) -- mpv $(cat kalkspace-player/mpv-options) kalkspace-player/video
		echo "KalkSpace Player quit! Restarting...Press Ctrl+C to interrupt..."
                sleep 5
        done
fi
