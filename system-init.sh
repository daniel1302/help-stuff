# This is script for Arch linux, that help me start up new system instance .

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

# Install AWC CLI
sudo pacman -S aws-cli;

# Add command aws_auth
echo '#!/bin/bash' | sudo \
	tee /bin/aws_auth > /dev/null \
&& echo 'CMD=`echo "sudo $(aws ecr get-login --region us-east-1)" | sed "s/[ ]*\-e[ ]*none[ ]*/ /g"`; $CMD;' | sudo \
	tee --append /bin/aws_auth > /dev/null 
&& sudo chmod +x /bin/aws_auth; 

# Add transfer command, that can upload files to http://transfer.sh
echo 'transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi' >> ~/.bashrc \
&& echo 'tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }' >> ~/.bashrc \
&& source ~/.bashrc
