#!/bin/bash

cd /var/www/html && rm -rf index.html && php -S 0.0.0.0:8080 -t /var/www/html /var/www/html/adminer.php
