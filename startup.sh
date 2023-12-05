#!/bin/sh

for i in "app" "app1" "app2" "app3" "live" "ready" "healthz"; do
  /bin/hostname > /$i/index.html
done

/usr/sbin/nginx -g "daemon off;"
