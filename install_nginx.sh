#!/bin/bash 

###################################################################
#Script Name	: install_nginx.sh
#Description	: Install Nginx web server.
#Args           : 
#Author       	: Dilesh Fernando
#Email         	: fernando.dilesh@gmail.com
###################################################################

sudo apt-get install nginx apache2-utils -y
sudo nginx -t
sudo systemctl enable nginx.service
sudo systemctl restart nginx.service