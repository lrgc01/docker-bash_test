#!/bin/bash

# Environment: Docker CE, CentOS 7, HAProxy 1.6, Nginx any version
# Note: the same image could be achieved using the Dockerfile in this directory.

# Some names to repeat
NAME1=nginxSite1
NAME2=nginxSite2
IMG_NAME=nginx_haproxy
ENTRYP_SCRIPT="nginx-entrypoint.sh"

# Pull base environment - Centos official docker
docker pull centos

# $IMG_NAME will be used both for image and container names in the meantime
# First run docker base system to install nginx and HAProxy
# Will use epel and ius open repos.
docker run --name $IMG_NAME -i --attach=STDIN --attach=STDOUT --attach=STDERR centos /bin/bash << EOF
yum install -y epel-release 
rpm -Uvh https://centos7.iuscommunity.org/ius-release.rpm 
yum install -y nginx haproxy18u
yum clean all

EOF

# Save changes of centos image with nginx and haproxy.
docker container commit -m="Installed nginx haproxy18u" $IMG_NAME $IMG_NAME

# Configuration starting from our local files
docker cp $ENTRYP_SCRIPT $IMG_NAME:/
docker cp haproxy.cfg $IMG_NAME:/etc/haproxy
docker cp index.tmpl $IMG_NAME:/usr/share/nginx/html

# Finally a base image that runs two haproxies
docker container commit -m="Configured nginx haproxy18u and entrypoint" $IMG_NAME ${IMG_NAME}:1

# Run 2 dockers based on the same image, i.e. 2 identical containers except by their published ports.
docker run -d --name $NAME1 --publish=80:80 --publish=8000:8000 ${IMG_NAME}:1 /$ENTRYP_SCRIPT
docker run -d --name $NAME2 --publish=81:80 --publish=8001:8000 ${IMG_NAME}:1 /$ENTRYP_SCRIPT

# May create two images but the above published ports won't be preserved.
# Actually these two images below are identical except by the commit message.
#docker container commit -m="Out ports 80 and 8000" $NAME1 ${IMG_NAME}:srv1
#docker container commit -m="Out ports 81 and 8001" $NAME1 ${IMG_NAME}:srv2

###########################
#
# To test, go to your server IP ports 8000 and 8001:
# eg.: http://<my_server_ip>:8000
# and refresh the page (F5). The "Website ID" will change.

# Before re-runing this script, make sure to erase every container and image or change the names.
