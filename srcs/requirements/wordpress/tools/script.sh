#!/bin/bash


sleep 20


# if [ ! -d "/Users/aelbrahm/goinfre/Inception/data" ]; then
#         mkdir /Users/aelbrahm/goinfre/Inception/data
#         mkdir /Users/aelbrahm/goinfre/Inception/data/mariadb
#         mkdir /Users/aelbrahm/goinfre/Inception/data/wordpress
# fi

service php7.4-fpm start

file="/etc/php/7.4/fpm/pool.d/www.conf"
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' "$file"


wp core download --path=/var/www/html/ --allow-root

wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --path=/var/www/html --allow-root
wp plugin update --all --path=/var/www/html --allow-root

file="/var/www/html/wp-config.php"
sed -i "s|database_name_here|${MYSQL_DATABASE_NAME}|g" "$file"
sed -i "s|username_here|${MYSQL_USER}|g" "$file"
sed -i "s|password_here|${MYSQL_PASSWORD}|g" "$file"


service php7.4-fpm stop
/usr/sbin/php-fpm7.4 -F