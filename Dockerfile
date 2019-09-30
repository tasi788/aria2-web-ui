FROM opengg/aria2

LABEL AUTHOR = tdc<tdc@tdccc.com.tw>

WORKDIR /root

RUN apk update && apk add wget bash curl darkhttpd --no-cache

ADD config /root/conf

RUN mkdir -p /usr/local/www && mkdir -p /usr/local/www/aria2


RUN mkdir /usr/local/www/aria2/Download && cd /usr/local/www/aria2 \
    && version=1.1.3 \
    && wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip \
    && unzip AriaNg-${version}.zip \
    && rm -rf AriaNg-${version}.zip \
    && chmod -R 755 /usr/local/www/aria2 \
    && chmod +x /root/conf/aria2c.sh

EXPOSE 6800 80

ENTRYPOINT ["/bin/sh", "/root/conf/aria2c.sh"]