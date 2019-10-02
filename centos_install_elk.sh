#!/bin/bash 

###################################################################
#Script Name	: centos_install_elk.sh
#Description	: Install ELK stack on CentOS 7.
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

echo -e "\n${RED}Install Java 8${NC}"
yum install -y java-1.8.0-openjdk

echo "Import PGP Key"
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

echo "Create Yum repository"
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

echo "Install Elasticsearch"
yum install -y elasticsearch

echo "Enable and start elasticsearch service"
systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch

echo "Install kibana"
yum install -y kibana

echo "Enable and start kibana service"
systemctl daemon-reload
systemctl enable kibana
systemctl start kibana

echo "Install Nginx"
yum install -y epel-release
yum install -y nginx

echo "Create Proxy configuration"
#Remove server block from the default config file /etc/nginx/nginx.conf And create a new config file

cat >>/etc/nginx/conf.d/kibana.conf<<EOF
server {
    listen 80;
    server_name server.example.com;
    location / {
        proxy_pass http://localhost:5601;
    }
}
EOF

echo "Enable and start nginx service"
systemctl enable nginx
systemctl start nginx

echo "Install logstash"
yum install -y logstash

echo "Install OpenSSL"
yum install openssl

echo "Generate SSL Certificates"
openssl req -subj '/CN=server.example.com/' -x509 -days 3650 -nodes -batch -newkey rsa:2048 -keyout /etc/pki/tls/private/logstash.key -out /etc/pki/tls/certs/logstash.crt

echo "Create Logstash config file"
cat >>/etc/logstash/conf.d/01-logstash-simple.conf<<EOF
input {
  beats {
    port => 5044
    ssl => true
    ssl_certificate => "/etc/pki/tls/certs/logstash.crt"
    ssl_key => "/etc/pki/tls/private/logstash.key"
  }
}

filter {
    if [type] == "syslog" {
        grok {
            match => {
                "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}"
            }
            add_field => [ "received_at", "%{@timestamp}" ]
            add_field => [ "received_from", "%{host}" ]
        }
        syslog_pri { }
        date {
            match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
        }
    }
}

output {
    elasticsearch {
        hosts => "localhost:9200"
        index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    }
}
EOF

echo "Enable and Start logstash service"
systemctl enable logstash
systemctl start logstash