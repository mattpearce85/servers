# servers

```
sudo docker run --name php5-service \
  -v /home/mattpearce85/servers/webroot/php5:/var/www/html/php5 \
  -d -p 9000:9000 php:5.6-fpm
sudo docker run --name php7-service \
  -v /home/mattpearce85/servers/webroot/php7:/var/www/html/php7 \
  -d -p 9001:9000 php:7.2-fpm
sudo docker run --name perl-service \
  -v /home/mattpearce85/servers/webroot/perl:/srv/www/perl \
  -d -p 9002:9000 spaletta/fcgiwrap-perl:latest
sudo docker run --name mariadb-service \
  -v /home/mattpearce85/servers/webroot/mariadb:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -d mariadb:10.3.9
sudo docker run --name phpmyadmin-service \
  -v /home/mattpearce85/servers/webroot/phpmyadmin/config.user.inc.php:/etc/phpmyadmin/config.user.inc.php \
  -v /home/mattpearce85/servers/webroot/phpmyadmin/sessions:/sessions \
  -e PMA_HOST=mariadb-service \
  -e PMA_PORT=3306 \
  -e PMA_ABSOLUTE_URI=https://pma.fancords.com \
  --link mariadb-service -d phpmyadmin/phpmyadmin
sudo docker run --name nginx-service \
  -v /home/mattpearce85/servers/nginx/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/mattpearce85/servers/nginx/sites-enabled:/etc/nginx/sites-enabled/ \
  -v /home/mattpearce85/servers/webroot/php5:/var/www/html/php5 \
  -v /home/mattpearce85/servers/webroot/php7:/var/www/html/php7 \
  -v /home/mattpearce85/servers/webroot/perl:/srv/www/perl \
  --link php5-service --link php7-service --link perl-service --link phpmyadmin-service -d -p 80:80 nginx

```
