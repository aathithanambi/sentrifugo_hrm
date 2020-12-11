FROM ubuntu:trusty
MAINTAINER AATHITHANAMBI <aathithanambi@gmail.com>

RUN apt-get update && apt-get install -y \
apache2-bin \
libapache2-mod-php5 \
php5-curl \
php5-ldap \
php5-mysql \
php5-mcrypt \
php5-gd \
patch \
curl \
vim \
git \
mysql-client

RUN php5enmod mcrypt
RUN php5enmod gd
RUN a2enmod rewrite

RUN sed -i 's/variables_order = .*/variables_order = "EGPCS"/' /etc/php5/apache2/php.ini
RUN sed -i 's/variables_order = .*/variables_order = "EGPCS"/' /etc/php5/cli/php.ini

RUN useradd --uid 1000 --gid 50 docker

RUN echo export APACHE_RUN_USER=docker >> /etc/apache2/envvars
RUN echo export APACHE_RUN_GROUP=staff >> /etc/apache2/envvars

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN chown -R docker /var/www/html
WORKDIR /var/www/html

RUN apt-get install zip unzip
RUN apt-get install wget
RUN wget -q "http://www.sentrifugo.com/home/downloadfile?file_name=Sentrifugo.zip" -O Sentrifugo.zip && \
unzip Sentrifugo.zip && mv Sentrifugo_3.2 sentrifugo

WORKDIR /var/www/html/sentrifugo

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN chmod 777 -R public/downloads public/uploads public/email_constants.php \
public/emptabconfigure.php \
public/site_constants.php \
public/db_constants.php \
public/application_constants.php \
public/mail_settings_constants.php \
logs/application.log \
application/modules/default/plugins/AccessControl.php \
install

VOLUME /var/www/html/sentrifugo/public/uploads

VOLUME /var/www/html/sentrifugo/public/downloads

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 443
