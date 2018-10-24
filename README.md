# servers

sudo docker run --name php5 \
  -v /home/mattpearce85/servers/php5:/var/www/html/php5 \
  -d -p 9000:9000 php:5.6-fpm

sudo docker run --name php7 \
  -v /home/mattpearce85/servers/php7:/var/www/html/php7 \
  -d -p 9001:9000 php:7.2-fpm

sudo docker run --name perl \
  -v /home/mattpearce85/servers/perl:/srv/www/perl \
  -d -p 9002:9000 spaletta/fcgiwrap-perl:latest

sudo docker run --name nginx-cache \
  -v /home/mattpearce85/servers/nginx/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/mattpearce85/servers/nginx/sites-enabled:/etc/nginx/sites-enabled/ \
  -v /home/mattpearce85/servers/php5:/var/www/html/php5 \
  -v /home/mattpearce85/servers/php7:/var/www/html/php7 \
  -v /home/mattpearce85/servers/perl:/srv/www/perl \
  --link php5 --link php7 --link perl -d -p 80:80 nginx

