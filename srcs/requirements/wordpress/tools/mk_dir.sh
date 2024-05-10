#!/bin/bash

if [ ! -d "/home/$USER/data" ]; then
        mkdir -p /home/$USER/data/mariadb
        mkdir -p /home/$USER/data/wordpress
fi