#For Fairgate
FROM ubuntu:18.04

MAINTAINER rajith.r@pitsolutions.com

RUN apt-get update && apt-get -y install software-properties-common

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update

RUN  DEBIAN_FRONTEND=noninteractive  apt-get install -y apache2 apache2-dev \
    php7.3-zip php7.3-bcmath php7.3-curl curl php7.3-fileinfo php7.3-zip php7.3-gd php7.3-iconv php7.3-imap php7.3-intl php7.3-json php7.3-xml php7.3-mbstring  php7.3-mysql php7.3-soap \
    mysql-client-5.7 zip unzip graphicsmagick php7.3-dev autoconf automake php7.3-gmagick php-apcu wget libapache2-mod-php7.3 php-zmq

RUN apt-get update && apt-get -y install fontconfig libssl1.0.0 libxrender1 xfonts-75dpi xfonts-base \
    && wget -O /tmp/wkhtmltox_0.12.1.3-1~bionic_amd64.deb https://builds.wkhtmltopdf.org/0.12.1.3/wkhtmltox_0.12.1.3-1~bionic_amd64.deb \
    && dpkg -i /tmp/wkhtmltox_0.12.1.3-1~bionic_amd64.deb && apt-get install -f && ln -s /usr/local/bin/wkhtmltopdf /usr/bin && apt-get clean &&  rm -rf /var/lib/apt/lists/*


RUN wget -O /usr/local/bin/composer https://getcomposer.org/download/1.8.6/composer.phar && chmod +x /usr/local/bin/composer

RUN chown -R www-data:www-data /var/www/html
RUN a2enmod rewrite
WORKDIR /var/www/html/fairgate

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ports.conf /etc/apache2/ports.conf

COPY php.ini /etc/php/7.3/apache2/php.ini

EXPOSE 80
EXPOSE 81

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

