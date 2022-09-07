#!/bin/bash

user=$(who | cut -f1 -d' ')

[[ -d /home/$user ]] || { mkdir -m=0700 /home/$user; chown $user:$user; }

echo "Done !"

