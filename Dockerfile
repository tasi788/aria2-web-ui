FROM alpine:edge

LABEL AUTHOR = tdc<tdc@tdccc.com.tw>

WORKDIR /root

ENV RPC_SECRET=Henry
ENV RPC_SECURE=false

RUN apk update && apk add wget bash curl openrc gnupg screen aria2 darkhttpd tar --no-cache

ADD conf /root/conf

RUN mkdir -p /usr/local/www && mkdir -p /usr/local/www/aria2

RUN mkdir /usr/local/www/aria2/Download && cd /usr/local/www/aria2 \
    && chmod +rw /root/conf/aria2.session \
    && version=1.1.3 \
    && wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip \
    && unzip AriaNg-${version}.zip \
    && rm -rf AriaNg-${version}.zip \
    && chmod -R 755 /usr/local/www/aria2 \
    && chmod +x /root/conf/aria2c.sh

VOLUME /root/conf/key

VOLUME /data

EXPOSE 6800 80

ENTRYPOINT ["/bin/sh", "/root/conf/aria2c.sh"]