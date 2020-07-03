FROM alpine:3.11
RUN apk add --no-cache certbot
# process wrapper
WORKDIR /app
LABEL maintainer "sebs sebsclub@outlook.com"
ENV TROJAN_VERSION 1.16.0
RUN apk add --no-cache --virtual build-dependencies libpng-dev build-base certbot bash tzdata cmake boost-dev openssl-dev mariadb-connector-c-dev && \
    wget https://github.com/trojan-gfw/trojan/archive/v${TROJAN_VERSION}.tar.gz && \
    tar zxf v${TROJAN_VERSION}.tar.gz && \
    cd trojan-${TROJAN_VERSION} && \
    cmake . && \
    make && \
    strip -s trojan && \
    mv trojan /usr/local/bin && \
    apk add --no-cache --virtual .trojan-rundeps libstdc++ boost-system boost-program_options mariadb-connector-c && \
    rm -rf /var/cache/apk /usr/share/man /root/trojan-${TROJAN_VERSION} /root/v${TROJAN_VERSION}.tar.gz &&\
    cd &&\
    wget https://fukuchi.org/works/qrencode/qrencode-4.0.2.tar.gz && \
    tar zxf qrencode-4.0.2.tar.gz && \
    cd qrencode-4.0.2 && \
    cmake . && \
    make && \
    strip -s qrencode && \
    mv qrencode /usr/local/bin
COPY trojan.json /app/trojan.json
ADD start.sh /start.sh
ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt
EXPOSE 443 80
ENTRYPOINT ["sh","/start.sh"]
# CMD [ "trojan" ]
