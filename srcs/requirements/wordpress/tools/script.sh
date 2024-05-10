#!/bin/bash


sleep 10

service php7.4-fpm start

file="/etc/php/7.4/fpm/pool.d/www.conf"

#FPM CONFIGURATION
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' "$file"

file="/var/www/html/wp-config.php"
mv wp-config.php /var/www/html
sed -i "s|database_name_here|${MYSQL_DATABASE_NAME}|g" "$file"
sed -i "s|username_here|${MYSQL_USER}|g" "$file"
sed -i "s|password_here|${MYSQL_PASSWORD}|g" "$file"

#WORDPRESS load
wp core download --path=/var/www/html/ --allow-root

#WP USER CONFIG
wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path=/var/www/html --skip-email --allow-root
wp user create ${WP_USER} ${WP_EMAIL} --role=author --user_pass=${WP_PASSWORD} --path=/var/www/html --allow-root
#WP REDIS PLUGIN & THEME DOWNLOAD
wp plugin install redis-cache --activate --path=/var/www/html --allow-root
wp plugin update --all --path=/var/www/html --allow-root
wp redis enable --path=/var/www/html  --allow-root
wp theme install codeify --activate --path=/var/www/html --allow-root
service php7.4-fpm stop

adduser --home /var/www/html $FTP_USR --disabled-password


chown -R www-data:www-data /var/www/html
chown -R $FTP_USR:$FTP_USR /var/www/html/wp-content

/usr/sbin/php-fpm7.4 -F
