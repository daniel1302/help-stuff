# This is script for Arch linux, that help me start system.

# Update system
pacman -Syu --noconfirm;

# Install vim
pacman -S --noconfirm vim;

#Install tor-browser
pacman -S tor-browser;


# Install Sublime-Text Dev (https://www.sublimetext.com/docs/3/linux_repositories.html)
curl \
	-O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key  \
	--add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg \
&& echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" \
	| sudo tee -a /etc/pacman.conf \
&& sudo pacman -Syu --noconfirm sublime-text;


# Install mysql server and client
pacman -S --noconfirm \ 
	percona-server \
	percona-server-clients \
	libperconaserverclient \
	percona-toolkit;

# TODO: Init DB

# Install docker and docker machines
pacman -S --noconfirm \
	docker \
	docker-machine \
	docker-compose;

