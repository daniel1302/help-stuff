# This is script for Arch linux, that help me start up new system instance .

# Variables used in script
KERNEL_VERSION=$(echo `uname -r` | awk -F . '{print $1$2}');

# Update system
sudo pacman -Syu --noconfirm;

# Install vim
sudo pacman -S --noconfirm vim;

# Install sshfs
sudo pacman -S --noconfirm sshfs

# Install and configure git
sudo pacman -S --noconfirm git \
    && git config --global alias.tree "log --oneline --decorate --all --graph" \
    && git config --global core.editor vim;

# Install tor-browser
sudo pacman -S tor-browser;

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
sudo pacman -S --noconfirm aws-cli;

# Add command aws_auth
echo '#!/bin/bash' | sudo \
	tee /bin/aws_auth > /dev/null \
&& echo 'CMD=`echo "sudo $(aws ecr get-login --region us-east-1)" | sed "s/[ ]*\-e[ ]*none[ ]*/ /g"`; $CMD;' | sudo \
	tee --append /bin/aws_auth > /dev/null 
&& sudo chmod +x /bin/aws_auth; 

# Add transfer command, that can upload files to http://transfer.sh
echo 'transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi' >> ~/.bashrc \
&& echo 'tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }' >> ~/.bashrc \
&& source ~/.bashrc;

# Install PhpStorm
sudo curl --output /tmp/phpstorm-2017.2.4.tar.gz https://download-cf.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz \
&& sudo tar -xzvf /tmp/phpstorm-2017.2.4.tar.gz --directory /usr/share \
&& ls -l /usr/share | grep PhpStorm >> /dev/null \
&& sudo mv /usr/share/`ls -l /usr/share | grep PhpStorm | awk '{print $8}'` /usr/share/phpstorm \
&& sudo chown `whoami`:`whoami` -R /usr/share/phpstorm \
&& sudo rm /tmp/phpstorm-2017.2.4.tar.gz
&& sudo ln -s /usr/share/phpstorm/bin/phpstorm.sh /bin/phpstorm;


#Install CLion
sudo curl --output /tmp/CLion-2017.2.3.tar.gz https://download-cf.jetbrains.com/cpp/CLion-2017.2.3.tar.gz \
&& sudo tar -xzvf /tmp/CLion-2017.2.3.tar.gz --directory /usr/share \
&& ls -l /usr/share | grep clion >> /dev/null \
&& sudo mv /usr/share/`ls -l /usr/share | grep clion | awk '{print $8}'` /usr/share/clion \
&& sudo chown `whoami`:`whoami` -R /usr/share/clion \
&& sudo rm /tmp/CLion-2017.2.3.tar.gz \
&& sudo ln -s /usr/share/clion/bin/clion.sh /bin/clion;

# Install Mysql Workbech
sudo pacman -S --noconfirm mysql-workbench;

# Install virtualbox
sudo pacman -S --noconfirm \
	virtualbox \
	"linux${KERNEL_VERSION}-virtualbox-guest-modules" \
	"linux${KERNEL_VERSION}-virtualbox-host-modules";
	

# Install transmission with QT gui
sudo pacman -S --noconfirm transmission-qt;
