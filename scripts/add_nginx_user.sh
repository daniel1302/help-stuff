#!/usr/bin/env bash

echo -n "Type your username: ";
read USERNAME

if [ ${#USERNAME} -lt 3 ]; then
    echo "Username too short. Should have min 3 characters.";
    exit;
fi;

PASS_OK=0;
while [ $PASS_OK -lt 1 ]; do
    echo -n "Type your password: ";
    read -s PASS;
    echo ""

    echo -n "Retype your password: ";
    read -s PASS1
    echo ""

    if [ ${#PASS} -lt 3 ]; then
        echo ""
        echo "Password too short. Should have min 3 characters."
        echo ""
    elif [ "$PASS" == "$PASS1" ]; then
        PASS_OK=1
    else
        echo ""
        echo "Password Incorrect. Please try again."
        echo ""
    fi;
done;

echo -n "File with users[/etc/nginx/.htpasswd]: "
read FILE_PATH

if [ ${#FILE_PATH} -lt 1 ]; then
    FILE_PATH="/etc/nginx/.htpasswd";
fi;

echo "$USERNAME:"$(openssl passwd -apr1 $PASS) >> $FILE_PATH && echo "DONE" || echo "ERROR";
cat <<EOL


EXAMPLE PROTECTED BLOCK:

location / {
    try_files $uri $uri/ =404;
    auth_basic "Restricted Content";
    auth_basic_user_file /etc/nginx/.htpasswd;
}
EOL