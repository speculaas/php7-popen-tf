FROM ubuntu:16.04

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
      apache2 \
      php \
      php-cli \
      libapache2-mod-php \
      php-apcu \
      php-gd \
      php-json \
      php-ldap \
      php-mbstring \
      php-mysql \
      php-opcache \
      php-pgsql \
      php-sqlite3 \
      php-xml \
      php-xsl \
      php-zip \
      php-soap \
      php-xdebug \
      composer

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/local/bin/run"]


RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && apt-get install -y build-essential git python python-dev python-setuptools
RUN easy_install pip

WORKDIR /code/

# Add requirements and install
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
ADD ./requirements.txt /code/
RUN pip install -r ./requirements.txt

# Add service.conf
ADD /run.py /code/


