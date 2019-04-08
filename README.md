# servers

### Run commands
```
docker run --name mariadb-service \
  -v /home/mattpearce85/servers/mariadb:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=mysqltemp \
  -d -p 3306:3306 mariadb:10.3.9
docker run --name phpmyadmin-service \
  -v /home/mattpearce85/servers/phpmyadmin/config.user.inc.php:/etc/phpmyadmin/config.user.inc.php \
  -v /home/mattpearce85/servers/phpmyadmin/sessions:/sessions \
  -e PMA_HOST=mariadb-service \
  -e PMA_PORT=3306 \
  -e PMA_ABSOLUTE_URI=https://pma.fancords.com \
  --link mariadb-service -d phpmyadmin/phpmyadmin
docker run --name php5-service \
  -v /home/mattpearce85/servers/webroot/php5:/var/www/html/php5 \
  --link mariadb-service -d -p 9000:9000 vastblueshift/ubuntu-16.04-webserver:1.4.0-php5.6-fpm
docker run --name php7-service \
  -v /home/mattpearce85/servers/webroot/php7:/var/www/html/php7 \
  --link mariadb-service -d -p 9001:9000 vastblueshift/ubuntu-16.04-webserver:1.4.0-php7.2-fpm
docker run --name perl-service \
  -v /home/mattpearce85/servers/webroot/perl:/var/www/html/perl \
  --link mariadb-service -d -p 9002:9000 vastblueshift/fcgiwrap-perl:latest
docker run --name theia-service \
  -v "/home/mattpearce85:/home/project:cached" \
  -d -p 3000:3000 -u 1000:1000 theiaide/theia:next
docker run --name nginx-service \
  -v /home/mattpearce85/servers/nginx/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/mattpearce85/servers/nginx/sites-enabled:/etc/nginx/sites-enabled \
  -v /home/mattpearce85/servers/webroot:/var/www/html \
  -v /home/mattpearce85/.htpasswd:/etc/nginx/.htpasswd \
  --link php5-service --link php7-service --link perl-service --link phpmyadmin-service --link theia-service -d -p 80:80 nginx

```

### Kill and remove all docker containers
```
docker kill $(docker ps -aq)
docker rm -f $(docker ps -aq)

```

### Remove all docker images
```
sudo docker rmi -f $(sudo docker images -q)

```

### Common commands
```
sudo docker exec -it php5-service bash
sudo docker exec -it phpmyadmin-service sh

service nginx reload
```
