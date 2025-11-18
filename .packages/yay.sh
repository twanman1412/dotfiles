#!/bin/bash
set -euo pipefail

if pacman -Qi yay>/dev/null 2>&1; then
    echo "Yay is already installed."
else
	echo "Installing Yay AUR helper"

	git clone https://aur.archlinux.org/yay.git
	cd yay

	makepkg PKGBUILD
	sudo pacman -U yay-*.tar.zst --noconfirm --needed

	cd ..
	rm -rf yay
fi
