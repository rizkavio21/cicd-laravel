FROM '123majumundur/php-7.1-nginx:cicd'
MAINTAINER Robby Dwi <robbie.developer@gmail.com>

#install pressimo for faster deps installation
RUN composer global require hirak/prestissimo

#Make direcotory for hosting the apps
RUN mkdir /home/app/app
WORKDIR /home/app/app

#install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

#copy codebase
COPY --chown=app:root . ./

#Finish Composer
#RUN composer dump autoload 
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080