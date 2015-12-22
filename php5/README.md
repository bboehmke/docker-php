# PHP 5 FPM

PHP 5 FPM daemon as docker image

## Usage

Start the container with:
```sh
docker run -d --name=php5 \
    --restart=always \
    -v /run/php5:/run/php \
    -v /srv/www:/srv/www \
    bboehmke/php:5-fpm
```

Use the FPM socket "/run/php5/php5-fpm.sock" in NGINX.

Note: All files used in PHP scripts must have the same path in the conatiner 
as on the host. In this case all files are in "/srv/www".
