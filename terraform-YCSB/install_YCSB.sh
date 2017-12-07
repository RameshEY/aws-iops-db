sudo apt-get update
sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk
sudo ln -s /home/ubuntu/ycsb-0.12.0/bin/ycsb.sh /etc/alternatives/ycsb
sudo ln -s /etc/alternatives/ycsb /usr/bin/ycsb
