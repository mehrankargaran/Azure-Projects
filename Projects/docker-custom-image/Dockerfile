
FROM ubuntu:22.04

LABEL Author="Kargaran"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y apache2 git && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

ADD nano.tar.gz /var/www/html

VOLUME /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
