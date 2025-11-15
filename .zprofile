if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
	exec uwsm start hyprland
fi

