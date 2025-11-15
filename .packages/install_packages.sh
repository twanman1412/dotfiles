#!/bin/bash

echo "Updating repositories"
sudo pacman -Syu --noconfirm

for file in [0-9][0-9]-*; do
	[ -f "$file" ] || continue

	echo "Installing packages from $file"

	pkgs=$(tr '\n' ' ' < "$file")
	if [ -z "$pkgs" ]; then
		echo "	File is empty, skipping."
		continue
	fi

	echo "	Running: sudo pacman -S --noconfirm --needed $pkgs"
	sudo pacman -S --noconfirm --needed $pkgs
done

