#!/bin/bash -v



#
# apt
#
DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64 ] http://repo.mongodb.com/apt/ubuntu trusty/mongodb-enterprise/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list
DEBIAN_FRONTEND=noninteractive apt-key update -y
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y awscli
DEBIAN_FRONTEND=noninteractive apt-get install -y ntp

#
# RAID-0 local ephemeral SSDs on /data
#
if [ "${config_ephemeral}" == "true" ]; then
  DEBIAN_FRONTEND=noninteractive apt-get install -y mdadm
  umount /mnt

  mkdir -p /opt
  yes | mdadm --create --verbose /dev/md0 --level=0 --name=opt --raid-devices=2 /dev/xvdb /dev/xvdc
  mkfs.ext4 -L opt /dev/md0
  mount LABEL=opt /opt
fi

#
# EBS SSDs for persistence on /opt
#
if [ "${config_ebs}" == "true" ]; then

  # wait until the volume is attached
  while [ ! -e /dev/xvdz ]; do
    echo "Waiting for EBS /dev/xvdz volume to attach to instance .. "
    sleep 1;
  done
  mkdir -p /opt

  #
  # IMPORTANT: only format the volume if uninitialized (i.e. first boot for a fresh volume)
  #
  parted /dev/xvdz print || mkfs.ext4 -L opt /dev/xvdz
  mount LABEL=opt /opt
fi

#
# MongoDB Tuning
#
echo LC_ALL=\"en_US.UTF-8\" >> /etc/default/locale

# kernel tuning recommended by MongoDB
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag

# virtual memory tuning
#dirty ratio  and dirtybackground ratio change
vm.swapiness=0
#

# shorter keepalives, 120s recommended for MongoDB in official docs:
# https://docs.mongodb.org/manual/faq/diagnostics/#does-tcp-keepalive-time-affect-mongodb-deployments
sysctl -w net.ipv4.tcp_keepalive_time=120
cat << EOF > /etc/sysctl.conf
net.ipv4.tcp_keepalive_time = 120
fs.file-max = 65536
vm.dirty_ratio=15
vm.dirty_background_ratio=5
vm.swapiness=0
EOF
sysctl -p

# MongoDB prefers file limits > 20,000
cat << EOF > /etc/security/limits.conf
* soft     nproc          65535
* hard     nproc          65535
* soft     nofile         65535
* hard     nofile         65535
EOF

# NUMA for MongoDB optimizations when supported
DEBIAN_FRONTEND=noninteractive apt-get install -y numactl

# required to avoid:
# "mongod: error while loading shared libraries: libnetsnmpmibs.so.30: cannot open shared object file: No such file or directory"
DEBIAN_FRONTEND=noninteractive apt-get install -y libsnmp-dev

  # Install MongoDB
  DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-enterprise=${mongodb_version} mongodb-enterprise-server=${mongodb_version} mongodb-enterprise-shell=${mongodb_version} mongodb-enterprise-mongos=${mongodb_version} mongodb-enterprise-tools=${mongodb_version}

  # prevent unintended upgrades by pinning the package
  echo "mongodb-enterprise hold" | dpkg --set-selections
  echo "mongodb-enterprise-server hold" | dpkg --set-selections
  echo "mongodb-enterprise-shell hold" | dpkg --set-selections
  echo "mongodb-enterprise-mongos hold" | dpkg --set-selections
  echo "mongodb-enterprise-tools hold" | dpkg --set-selections

  # NOTE: it sets mongodb user for everything inside! ("/opt/mongo")
  mkdir -p ${mongodb_basedir}
  chown mongodb:mongodb -R ${mongodb_basedir}

  # explicit default owner for parent directory ("/opt")
  chown root:root "$(dirname "${mongodb_basedir}")"

  # NOTE: it sets the permission for everything inside! (in "/opt")
  chmod 755 -R "$(dirname "${mongodb_basedir}")"

  # ensure ./mongo/data directory exists
  mkdir -p ${mongodb_basedir}/data
  chown mongodb:mongodb ${mongodb_basedir}/data

  # setup mongodb.key
  ENC_KEY_PATH=${mongodb_basedir}/mongodb.key

  chmod 600 $ENC_KEY_PATH
  chown mongodb:mongodb $ENC_KEY_PATH

  cat << EOF > /etc/mongod.conf
storage:
  dbPath: ${mongodb_basedir}/data
  journal:
    enabled: true
  engine: ${mongodb_conf_engine}

systemLog:
  destination: file
  logAppend: true
  path: ${mongodb_conf_logpath}

net:
  bindIp: 0.0.0.0
  port: 27017

security:
   keyFile: "$ENC_KEY_PATH"

EOF

  service mongod stop
  service mongod start









  mkdir -p ${mongodb_basedir}/backup-data
  chown mongodb:mongodb ${mongodb_basedir}/backup-data

  cp /etc/init/mongod.conf /etc/init/mongod-backup.conf
  sed -i "s/\/var\/lib\/mongodb/\/var\/lib\/mongodb-backup/g" /etc/init/mongod-backup.conf
  sed -i "s/\/var\/log\/mongodb/\/var\/log\/mongodb-backup/g" /etc/init/mongod-backup.conf
  sed -i "s/\/var\/run\/mongodb/\/var\/run\/mongodb-backup/g" /etc/init/mongod-backup.conf
  sed -i "s/\/etc\/mongod.conf/\/etc\/mongod-backup.conf/g" /etc/init/mongod-backup.conf
  sed -i "s/\/etc\/default\/mongod/\/etc\/default\/mongod-backup/g" /etc/init/mongod-backup.conf
  service mongod-backup start

  wget http://download.oracle.com/otn-pub/java/jdk/7u40-b43/jdk-7u40-linux-x64.rpm?AuthParam=11232426132 -o jdk-7u40-linux-x64.rpm
  rpm -Uvh jdk-7u40-linux-x64.rpm

  sudo yum install java-devel

  wget http://ftp.heanet.ie/mirrors/www.apache.org/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
  sudo tar xzf apache-maven-*-bin.tar.gz -C /usr/local
  cd /usr/local
  sudo ln -s apache-maven-* maven
  sudo vi /etc/profile.d/maven.sh

  export M2_HOME=/usr/local/maven


  bash
  mvn -version

  curl -O --location https://github.com/brianfrankcooper/YCSB/releases/download/0.5.0/ycsb-0.5.0.tar.gz
  tar xfvz ycsb-0.5.0.tar.gz
  cd ycsb-0.5.0


fi
