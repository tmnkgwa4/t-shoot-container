#!/bin/sh

/bin/hostname > /app/index.html
/bin/hostname > /app1/index.html
/bin/hostname > /app2/index.html
/bin/hostname > /app3/index.html
/usr/sbin/nginx -g "daemon off;"

