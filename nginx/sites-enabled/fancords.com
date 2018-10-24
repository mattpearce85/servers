server {
        listen 80;

        server_name fancords.com;

        root /var/www/html/php7/fancords.com/;
        index index.php index.html index.htm default.html default.htm;

        fastcgi_buffers 8 16k;
        fastcgi_buffer_size 32k;
        fastcgi_read_timeout 180;

        location ~ \.php$ {
            fastcgi_pass  php7:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param SERVER_NAME $server_name;
        }
}

