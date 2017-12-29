#!/bin/bash

#
# File: mgdb_install.sh
# Description: installs mongodb-enterprise
#
# References
# * https://docs.mongodb.com/manual/tutorial/install-mongodb-enterprise-on-ubuntu/
# * https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-16-04
# * https://askubuntu.com/questions/770054/mongodb-3-2-doesnt-start-on-lubuntu-16-04-lts-as-a-service
#

set -x

DEVICE_NAME=xvdh

#now provided by terraform
#mongodb_version="3.6.0"
#mongodb_basedir="/data/mongodb"
#mongodb_conf_engine="/etc/mongod.conf"
#mongodb_conf_logpath="/var/log/mongodb/mongod.log"

#DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
#echo "deb [ arch=amd64 ] http://repo.mongodb.com/apt/ubuntu trusty/mongodb-enterprise/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list

DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64,ppc64el,s390x ] http://repo.mongodb.com/apt/ubuntu xenial/mongodb-enterprise/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list

DEBIAN_FRONTEND=noninteractive apt-key update -y
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y awscli
DEBIAN_FRONTEND=noninteractive apt-get install -y ntp

# NUMA for MongoDB optimizations when supported
DEBIAN_FRONTEND=noninteractive apt-get install -y numactl

# required to avoid:
# "mongod: error while loading shared libraries: libnetsnmpmibs.so.30: cannot open shared object file: No such file or directory"
DEBIAN_FRONTEND=noninteractive apt-get install -y libsnmp-dev

# Install MongoDB
DEBIAN_FRONTEND=noninteractive apt-get install -y \
   mongodb-enterprise=${mongodb_version} \
   mongodb-enterprise-server=${mongodb_version} \
   mongodb-enterprise-shell=${mongodb_version} \
   mongodb-enterprise-mongos=${mongodb_version} \
   mongodb-enterprise-tools=${mongodb_version}

# prevent unintended upgrades by pinning the package
echo "mongodb-enterprise hold" | dpkg --set-selections
echo "mongodb-enterprise-server hold" | dpkg --set-selections
echo "mongodb-enterprise-shell hold" | dpkg --set-selections
echo "mongodb-enterprise-mongos hold" | dpkg --set-selections
echo "mongodb-enterprise-tools hold" | dpkg --set-selections

######### installation stuffs ############

mkdir -p ${mongodb_basedir}
useradd --home ${mongodb_basedir} --user-group mongodb

mkdir -p ${mongodb_basedir}/data
chown mongodb:mongodb ${mongodb_basedir}/data

#
# setup mongodb.key
# https://docs.mongodb.com/v2.6/tutorial/generate-key-file/
#

ENC_KEY_PATH=${mongodb_basedir}/mongodb.key
openssl rand -base64 741 > $ENC_KEY_PATH
chmod 600 $ENC_KEY_PATH
chown mongodb:mongodb $ENC_KEY_PATH

#
# log directory
#

mkdir -p /var/log/mongodb
chmod 755 /var/log/mongodb
chown mongodb:mongodb /var/log/mongodb

#
# configure mongodb
#

cat << EOF > /etc/mongod.conf
storage:
  dbPath: ${mongodb_basedir}/data
  journal:
    enabled: true
  engine: wiredTiger
  wiredTiger:
   engineConfig:
    cacheSizeGB: 30  
systemLog:
  destination: file
  logAppend: true
  path: ${mongodb_conf_logpath}
net:
  bindIp: 127.0.0.1,${database_private_ip}
  port: 27017
security:
   keyFile: "$ENC_KEY_PATH"
EOF

chown root:root /etc/mongod.conf
chmod 644 /etc/mongod.conf


#
# startup script
#

cat << EOF > /etc/systemd/system/mongodb.service
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
EOF

chown root:root /etc/systemd/system/mongodb.service
chmod 644 /etc/systemd/system/mongodb.service

#
# service start
#

sudo systemctl enable mongodb
sudo systemctl start mongodb
sudo systemctl status mongodb

#numactl --interleave=all mongod

#
# apply resource limits
#

cgclassify -g memory:DBLimitedGroup `pidof mongod`
