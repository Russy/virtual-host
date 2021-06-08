#!/bin/bash
read -p "Input folder path start from /var/www/: " path
read -p "Input virtual host: " host

virtualHost="
<VirtualHost *:80> \n
\n\t
	ServerName $host \n\t
	ServerAlias www.$host \n\t
	ServerAdmin webmaster@localhost \n\t
	DocumentRoot /var/www/$path \n\t
\n\t
    <Directory /var/www/$path> \n\t\t
        Options Indexes FollowSymLinks MultiViews \n\t\t
        AllowOverride All \n\t\t
        Require all granted \n\t\t
        Allow from all \n\t
    </Directory> \n\t
\n\t

	ErrorLog \${APACHE_LOG_DIR}/error.log \n\t
	CustomLog \${APACHE_LOG_DIR}/access.log combined \n\t
\n
</VirtualHost> \n
\n
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

"

echo -e $virtualHost > "/etc/apache2/sites-available/$host.conf"
sudo a2ensite "$host.conf"
sudo service apache2 restart

sudo echo "127.0.0.1 $host" >> "/etc/hosts"
