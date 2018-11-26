#!/usr/bin/env bash

[[ "$(whoami)" == "root" ]]                                         \
    && echo "Cannot run this script as a root. Run as normal user" \
    && exit;


# Install minimum requirements
#sudo pacman -Syu --noconfirm;
 sudo pacman-mirrors --fasttrack && sudo pacman -Syyu --noconfirm;

sudo pacman -S --noconfirm      \
    git                         \
    ansible                     \
    wget;


[[ -e ~/.ansible/plugins/modules/aur ]] && rm -rf ~/.ansible/plugins/modules/aur;


#git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur;
[ -e ansible-aur-git.gz ] && rm ansible-aur-git.gz;
wget https://aur.archlinux.org/cgit/aur.git/snapshot/ansible-aur-git.tar.gz -O ansible-aur-git.gz;
tar xvzf ansible-aur-git.gz \
	&& cd ansible-aur-git \
	&& makepkg -is --noconfirm \
	&& cd ../ \
	&& rm ansible-aur-git;




echo "";
echo "";
echo "";
echo "Now you can run your playbook";
sudo ansible-playbook ./main.yml
