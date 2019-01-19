#!/bin/bash

# Unconditionally change name inside index.html to reflect the server (just for testing)
cd /usr/share/nginx/html
HOSTNAME="`hostname`"
sed -e "s/__HOSTNAME__/$HOSTNAME/" < index.tmpl > index.html

cd /

# nginx is self detachable
nginx

# Run in foreground (-db)
haproxy -db -- /etc/haproxy/haproxy.cfg
