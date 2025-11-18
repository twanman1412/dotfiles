#!/bin/bash
set -euo pipefail

echo "Installing Docker"
sudo pacman -S docker --noconfirm --needed

echo "Enabling Docker service"
sudo systemctl enable --now docker.service

if pacman -Qi docker-desktop >/dev/null 2>&1; then
    echo "Docker Desktop is already installed."
else
	echo "Installing Docker Desktop"
	wget -O docker-desktop.pkg.tar.zst \
	  "https://desktop.docker.com/linux/main/amd64/210443/docker-desktop-x86_64.pkg.tar.zst?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64"

	sudo pacman -U docker-desktop.pkg.tar.zst --noconfirm --needed
	rm docker-desktop.pkg.tar.zst
fi
