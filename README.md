# servers

### Run commands
```
sudo docker run --name mysql-service \
  -v /home/mattpearce85/servers/mysql/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=mysqltemp \
  -d -p 3306:3306 -u 1000:1000 mysql:8.0.16 --log-bin \
  --character-set-server=utf8 --collation-server=utf8_general_ci --max-allowed-packet=512M --innodb-log-file-size=256M --wait-timeout=31536000 --innodb-lock-wait-timeout=500 --net-read-timeout=600 --net-write-timeout=600 --default-authentication-plugin=mysql_native_password
sudo docker run --name phpmyadmin-service \
  -v /home/mattpearce85/servers/phpmyadmin/config.user.inc.php:/etc/phpmyadmin/config.user.inc.php \
  -e PMA_HOST=mysql-service \
  -e PMA_PORT=3306 \
  --link mysql-service -d phpmyadmin/phpmyadmin
sudo docker run --name php5-service \
  -v /home/mattpearce85/servers/webroot/php5:/var/www/html/php5 \
  --link mysql-service -d -p 9000:9000 vastblueshift/ubuntu-16.04-webserver:1.4.0-php5.6-fpm
sudo docker run --name php7-service \
  -v /home/mattpearce85/servers/webroot/php7:/var/www/html/php7 \
  --link mysql-service -d -p 9001:9000 vastblueshift/ubuntu-16.04-webserver:1.4.0-php7.2-fpm
sudo docker run --name perl-service \
  -v /home/mattpearce85/servers/webroot/perl:/var/www/html/perl \
  --link mysql-service -d -p 9002:9000 vastblueshift/fcgiwrap-perl:latest
sudo docker run --name nginx-service \
  -v /home/mattpearce85/servers/nginx/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/mattpearce85/servers/nginx/sites-enabled:/etc/nginx/sites-enabled \
  -v /home/mattpearce85/servers/webroot:/var/www/html \
  -v /home/mattpearce85/.htpasswd:/etc/nginx/.htpasswd \
  --link php5-service --link php7-service --link perl-service --link phpmyadmin-service -d -p 80:80 nginx

```

### Kill and remove all docker containers
```
sudo docker kill $(sudo docker ps -aq)
sudo docker rm -f $(sudo docker ps -aq)

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
