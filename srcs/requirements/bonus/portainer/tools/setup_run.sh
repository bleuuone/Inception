#!/bin/bash

PORTAINER_HPWD=$(htpasswd -nb -B admin $PORTAINER_HPWD | cut -d ":" -f 2)
echo $PORTAINER_HPWD
./portainer/portainer --admin-password=$PORTAINER_HPWD
