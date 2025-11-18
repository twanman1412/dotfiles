#!/bin/bash
set -euo pipefail

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

echo "Installing flatpak"
sudo pacman -S --noconfirm --needed flatpak

echo "Installing flatpak packages"
fpkgs=$(tr '\n' ' ' < flatpak_packages)
if [ -z "$fpkgs" ]; then
	echo "	File is empty, skipping."
else
	echo "	Running: sudo flatpak install -y $fpkgs"
	sudo flatpak install -y $fpkgs
fi

echo "Installing yay"
sh yay.sh

echo "Updating yay repositories"
yay -Syu

echo "Installing yay packages"
ypkgs=$(tr '\n' ' ' < yay_packages)
if [ -z "$ypkgs" ]; then
	echo "	File is empty, skipping."
else
	echo "	Running: yay -S --noconfirm --needed $ypkgs"
	yay -S --noconfirm --needed $ypkgs
fi

