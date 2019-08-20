#!/bin/bash
echo "***Xdebug for docker install for homolog or dev env***"
echo "-Author: Breno R. Rodrigues <br3eno14@gmail.com>-"
echo ""

APP_ENV=$APP_ENV

if [ -z $APP_ENV ]; then
    echo "APP_ENV not found, please init docker with APP_ENV in LOCAL | HOMOL | PROD"
    echo "exit code 0"
    exit 0;
fi

echo "Config env project in $APP_ENV mode"

if [[ $APP_ENV == "PRODUCTION" || $APP_ENV == "PROD" ]]; then
    echo "Xdebug not installed in production mode"
    echo "Exit code 0"
    exit 0
fi

echo "$APP_ENV mode... Installing Xdebug"

#Installing dependencies and xdebug
apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-2.7.1 \
    && docker-php-ext-enable xdebug

echo "Xdebug Installed ! Initializing xdebug configuration..."
echo "Enabling xdebug.... \n\r Wait a second...."

XDEBUG_CONFIG_INI_PATH="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"

echo "xdebug.remote_enable=on" >> $XDEBUG_CONFIG_INI_PATH \
    && echo "xdebug.remote_handler=dbgp" >> $XDEBUG_CONFIG_INI_PATH \
    && echo "xdebug.remote_port=9000" >> $XDEBUG_CONFIG_INI_PATH \
    && echo "xdebug.remote_autostart=on" >> $XDEBUG_CONFIG_INI_PATH \
    && echo "xdebug.remote_connect_back=1" >> $XDEBUG_CONFIG_INI_PATH \
    && echo "xdebug.idekey=PHPSTORM" >> $XDEBUG_CONFIG_INI_PATH

echo "See a xdebug.ini conf"

cat $XDEBUG_CONFIG_INI_PATH

echo "Xdebug Installed And Configurated With Success"

echo "For any problem contact: br3eno14@gmail.com"

echo "Hope this helps"

exit 0
