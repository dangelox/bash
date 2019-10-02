#!/bin/bash 

###################################################################
#Script Name	: *.sh
#Description	: 
#Args           : 
#Author       	: Dilesh Fernando
#Email         	: fernando.dilesh@gmail.com
###################################################################

# Colors for console text
RED='\033[0;31m'
REDBLINK='\033[0;317m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color
#echo -e "\n${YELLOW}Text in color!${NC}"
# echo -e "\n${RED}
# ${NC}"

echo -e "\n${RED}Create Yum repository${NC}"
cat >>/etc/yum.repos.d/elk.repo<<EOF
[ELK-6.x]
name=ELK repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

echo -e "\n${RED}Install Filebeat${NC}"
yum install -y filebeat

echo -e "\n${RED}Copy SSL certificate from server.example.com${NC}"
scp 10.172.220.174:/etc/pki/tls/certs/logstash.crt /etc/pki/tls/certs/

echo -e "\n${RED}Configure Filebeat${NC}"
#sudo sed -i 's/enable: false/enable: true/' /etc/filebeat.filebeat.yml

echo -e "\n${RED}Enable and start Filebeat service${NC}"
systemctl enable filebeat
systemctl start filebeat