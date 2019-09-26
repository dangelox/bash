#!/bin/bash 

###################################################################
#Script Name	: install_elk.sh
#Description	: Install ELK stack on Ubuntu.
#Args           : 
#Author       	: Dilesh Fernando
#Email         	: fernando.dilesh@gmail.com
###################################################################
sudo apt-get update

echo "Installing Java "
sudo apt install openjdk-8-jdk
java -version
sudo echo $JAVA_HOME

echo "Installing and Configuring Elasticsearch"
sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update
sudo apt-get install elasticsearch
sudo sed -i 's/# network.host.*/network.host: localhost/' /etc/elasticsearch/elasticsearch.yml
sudo sed -i 's/# http.port.*/http.port: 9200/' /etc/elasticsearch/elasticsearch.yml
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo curl -XGET 'localhost:9200/?pretty'

echo "Installing Kibana"
sudo apt-get install kibana
sudo sed -i 's/#server.port.*/server.port: 5601/' /etc/kibana/kibana.yml
sudo sed -i 's/#server.host.*/server.host: "localhost"/' /etc/kibana/kibana.yml
sudo sed -i 's/#elasticsearch.hosts:.*/elasticsearch.hosts: ["http://localhost:9200"]/' /etc/kibana/kibana.yml
sudo systemctl enable kibana.service
sudo systemctl start kibana.service

echo "Installing and Configuring Logstash"
sudo apt-get install logstash


