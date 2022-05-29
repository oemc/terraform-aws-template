#!/bin/sh
amazon-linux-extras enable -y tomcat8.5
yum clean metadata
yum -y install tomcat
yum -y install amazon-efs-utils
mkdir /usr/share/tomcat/webapps/ROOT
mount -t efs -o tls fs-015b016bbe1449f6b.efs.us-west-2.amazonaws.com:/ /usr/share/tomcat/webapps/ROOT/
systemctl start tomcat