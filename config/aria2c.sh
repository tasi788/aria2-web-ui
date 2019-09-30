#!/bin/sh
/usr/bin/aria2c --conf-path="/config/aria2.conf" -D

darkhttpd /usr/local/www/aria2 --port 80