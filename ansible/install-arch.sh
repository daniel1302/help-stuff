#!/usr/bin/env bash

[[ "$(whoami)" == "root" ]]                                         \
    && echo "Cannot run this script as a root. Run as normal user" \
    && exit;

# Install minimum requirements
sudo pacman -S          \
    git                 \
    ansible             \
;

[[ -e ~/.ansible/plugins/modules/aur ]] && rm -rf ~/.ansible/plugins/modules/aur;


git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur;

echo "";
echo "";
echo "";
echo "Now you can run your playbook";