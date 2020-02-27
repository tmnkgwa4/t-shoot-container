#!/bin/sh

/bin/hostname > /app/index.html
/usr/sbin/nginx -g "daemon off;"

