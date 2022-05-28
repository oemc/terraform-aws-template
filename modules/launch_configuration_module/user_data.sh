#!/bin/sh
echo "## amazon-linux-extras enable -y nginx1"
amazon-linux-extras enable -y nginx1
echo "## yum clean metadata"
yum clean metadata
echo "## yum -y install nginx"
yum -y install nginx
echo "## aws s3 sync s3://omc-nclouds-bucket/mirror-image  /usr/share/nginx/html"
aws s3 sync s3://omc-nclouds-bucket/mirror-image  /usr/share/nginx/html
echo "## service nginx restart"
service nginx restart
echo "## nginx -s reload"
nginx -s reload