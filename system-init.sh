#!/bin/bash
# This is script for Arch linux, that help me start up new system instance .


[ `whoami` == "root" ] \
    && echo "Don not run it as root" \
    && exit 1;

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

# Install atom editor
sudo pacman -S --noconfirm atom;

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
	composer \
&& sudo systemctl enable php-fpm \
&& sudo systemctl start php-fpm;

# Install PHP CodeSniffer
sudo curl --output /bin/phpcs \
	-OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
&& sudo chmod +x /bin/phpcs;

sudo curl --output /tmp/php-compatibility.zip -OL https://github.com/wimg/PHPCompatibility/archive/8.1.0.zip \
&& sudo unzip -f /tmp/php-compatibility.zip -d /usr/lib/ \
&& sudo phpcs --config-set installed_paths /usr/lib/`ls -a /usr/lib | grep PHPCompatibility`;

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
	tee --append /bin/aws_auth > /dev/null \
&& sudo chmod +x /bin/aws_auth; 

# Add transfer command, that can upload files to http://transfer.sh
echo 'transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi' >> ~/.bashrc \
&& echo 'tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }' >> ~/.bashrc \
&& source ~/.bashrc;

# Install PhpStorm
[ ! -e /bin/phpstorm ] \
&& sudo curl --output /tmp/phpstorm-2017.2.4.tar.gz https://download-cf.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz \
&& sudo tar -xzvf /tmp/phpstorm-2017.2.4.tar.gz --directory /usr/share \
&& ls -l /usr/share | grep PhpStorm >> /dev/null \
&& sudo mv /usr/share/`ls -l /usr/share | grep PhpStorm | awk '{print $8}'` /usr/share/phpstorm \
&& sudo chown `whoami`:`whoami` -R /usr/share/phpstorm \
&& sudo rm /tmp/phpstorm-2017.2.4.tar.gz \
&& sudo ln -s /usr/share/phpstorm/bin/phpstorm.sh /bin/phpstorm;


#Install CLion
[ ! -e /bin/clion ] \
&& sudo curl --output /tmp/CLion-2017.2.3.tar.gz https://download-cf.jetbrains.com/cpp/CLion-2017.2.3.tar.gz \
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

# Install Netbeans
sudo pacman -S --noconfirm netbeans;

# Install Master PDF Editor
hash masterpdfeditor4 \
|| { \
    sudo pacman -S --noconfirm patchelf \
    && sudo curl --output /tmp/master-pdf-editor.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/masterpdfeditor.tar.gz \
    && sudo tar -xzvf /tmp/master-pdf-editor.tar.gz  --directory /tmp \
    && { \
	PKGDIR=`ls /tmp | grep masterpdfeditor`; \
	sudo chown `whoami`:`whoami` -R /tmp/$PKGDIR \
	&& cd /tmp/$PKGDIR \
	&& makepkg \
		-i \
		--noconfirm \
	&& sudo rm -R /tmp/$PKGDIR \
	&& sudo rm /tmp/master-pdf-editor.tar.gz; \
    }; \
};


# Install Terraform
[ ! -e /usr/local/bin/terraform ] \
&& echo "Installing terraform" \
&& sudo curl --output /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.6/terraform_0.11.6_linux_amd64.zip \
&&  { \
        cd /tmp \
	&& [ ! -e ./terraform ] \
	&& sudo unzip terraform.zip \
	&& sudo mv terraform /usr/local/bin/ \
	&& sudo chmod +x /usr/local/bin/terraform; \
} \
    && echo "Done" \
    && echo "Configuring Terraform for AWS" \
    && echo "tf() { env AWS_ACCESS_KEY_ID=\$(aws configure get profile.default.aws_access_key_id) AWS_SECRET_ACCESS_KEY=\$(aws configure get profile.default.aws_secret_access_key) terraform $@; }" >> ~/.bashrc;


# Instal Remmina
sudo pacman -S --noconfirm remmina;
    

#Install Slack Desktop
command -v slack >> /dev/null \
&& echo "Slack desktop is instaled yet. Instalation will be skipped." \
|| {
    sudo pacman -S --noconfirm libcurl-compat \
    && sudo curl --output /tmp/slack.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/slack-desktop.tar.gz \
    && sudo tar -xzvf /tmp/slack.tar.gz --directory /tmp \
    && sudo rm /tmp/slack.tar.gz \
    && { \
        PKGDIR=`ls /tmp | grep slack-desktop`; \
        sudo chown `whoami`:`whoami` -R /tmp/$PKGDIR \
        && cd /tmp/$PKGDIR \
        && makepkg -i \
	&& sudo rm -R /tmp/$PKGDIR;
    }; \
}; 

#Install GO Lang
sudo pacman -S go;

# Apply PHP Code Sniffer scanner into .bashrc
echo "phpCsScan()" >> ~/.bashrc \
&& echo "{" >> ~/.bashrc \
&& echo "    if [ ! \$# -eq 2 ] || [ ! -d \"\$1\" ] || [ ! -d \"\$2\" ];" >> ~/.bashrc \
&& echo "    then" >> ~/.bashrc \
&& echo "        echo \"Usage: phpCsScan SCANNED_DIRECTORY REPORT_OUTPUT_DIRECTORY\";" >> ~/.bashrc \
&& echo "        return 1;" >> ~/.bashrc \
&& echo "    fi;" >> ~/.bashrc \
&& echo "" >> ~/.bashrc \
&& echo "    scanDIR=\"\$1\"" >> ~/.bashrc \
&& echo "" >> ~/.bashrc \
&& echo "    for dir in \$(find \"\$scanDIR\" -mindepth 1 -maxdepth 1 -type d);" >> ~/.bashrc \
&& echo "    do" >> ~/.bashrc \
&& echo "        dir=\${dir%*/}" >> ~/.bashrc \
&& echo "        dir=\${dir##*/}" >> ~/.bashrc \
&& echo "        outputDIR=\$2" >> ~/.bashrc \
&& echo "        outputDIR=\${outputDIR%*/}" >> ~/.bashrc \
&& echo "" >> ~/.bashrc \
&& echo "        echo \"Analysing \$dir...\";" >> ~/.bashrc \
&& echo "        php -dmemory_limit=-1 /usr/bin/phpcs -p \"\$scanDIR/\$dir\" --standard=PHPCompatibility > \"\$outputDIR/\$dir.txt\";" >> ~/.bashrc \
&& echo "        echo \"Writing results into  \$outputDIR/\$dir.txt\";" >> ~/.bashrc \
&& echo "        echo \"done.\"" >> ~/.bashrc \
&& echo "    done;" >> ~/.bashrc \
&& echo "" >> ~/.bashrc \
&& echo "}" >> ~/.bashrc;



# Install PHPUnit6
[ -e /usr/bin/phpunit6 ] \
  && echo "Removing /usr/bin/phpunit6..." \
  && sudo rm /usr/bin/phpunit6 \
  && echo "Done";
  
  [ -e /usr/bin/phpunit ] \
    && echo "Removing /usr/bin/phpunit..." \
    && sudo rm /usr/bin/phpunit \
    && echo "Done";

sudo curl --output /usr/bin/phpunit6 -OL https://phar.phpunit.de/phpunit-6.phar \
&& sudo chmod +x /usr/bin/phpunit6 \
&& sudo ln -s /usr/bin/phpunit6 /usr/bin/phpunit;

# Install PHPUnit5
[ -e /usr/bin/phpunit5 ] \
  && echo "Removing /usr/bin/phpunit5..." \
  && sudo rm /usr/bin/phpunit5 \
  && echo "Done";

sudo curl --output /usr/bin/phpunit5 -OL https://phar.phpunit.de/phpunit-5.phar \
&& sudo chmod +x /usr/bin/phpunit5;



#Insall Keepass and google sync plugin

[ -e /tmp/google-keepass.zip ] \
    && sudo rm /tmp/google-keepass.zip;

sudo pacman -S --noconfirm \
        keepass \
    && sudo curl \
        --output /tmp/google-keepass.zip \
	-OL https://netcologne.dl.sourceforge.net/project/kp-googlesync/GoogleSyncPlugin-3.x/GoogleSyncPlugin-3.0.1.zip \
   && sudo unzip /tmp/google-keepass.zip -d /usr/share/keepass;
    
# Reload ~/.bashrc    
source ~/.bashrc;
