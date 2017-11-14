# This is script for Arch linux, that help me start system.

# Update system
pacman -Syu --noconfirm;

# Install vim
pacman -S --noconfirm vim;

# Install tor-browser
pacman -S tor-browser;

# Install Meld
sudo pacman -S --noconfirm meld;

# Install Sublime-Text Dev (https://www.sublimetext.com/docs/3/linux_repositories.html)
curl \
	-O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key  \
	--add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg \
&& echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" \
	| sudo tee -a /etc/pacman.conf \
&& sudo pacman -Syu --noconfirm sublime-text;

# Install nginx web server
sudo pacman -S --noconfirm \
	nginx \
&& sudo systemctl enable nginx \
&& sudo systemctl start nginx;

# Install PHP and PHP extensions
sudo pacman -S --noconfirm \
	php \
	php-fpm \
	php-pgsql \
	php-mongodb \
	php-gd \
	php-imap \
	php-intl \
	php-mcrypt \ 
	composer \
&& sudo systemctl enable php-fpm \
&& sudo systemctl start php-fpm;

# Install mysql server and client
sudo pacman -S --noconfirm \ 
	percona-server \
	percona-server-clients \
	libperconaserverclient \
	percona-toolkit \
&& sudo systemctl enable mysqld \
&& sudo systemctl start mysqld;

# TODO: Init DB

# Install docker and docker machines
sudo pacman -S --noconfirm \
	docker \
	docker-machine \
	docker-compose \
&& sudo systemctl enable iptables \
&& sudo systemctl start iptables \
&& sudo systemctl enable docker \
&& sudo systemctl start docker;

