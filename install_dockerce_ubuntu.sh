#!/bin/bash 

###################################################################
#Script Name	: install_dockerce_ubuntu.sh
#Description	: Install Docker CE in Ubuntu 18.04 (bonic).
#Args           : 
#Author       	: Dilesh Fernando
#Email         	: fernando.dilesh@gmail.com
#Notes			: If error executing script regarding line return 
#				  (\r), use dos2unix convert the file format to 
#				  unix format. This will occur when script are 
#				  windows environment
###################################################################

# Colors for console text
RED='\033[0;31m'
REDBLINK='\033[0;317m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

##########################Start Script#############################

echo -e "\n${PURPLE}Install and Use Docker on Ubuntu 18.04${NC}"

echo -e "\n${YELLOW}Update OS and packages${NC}"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common

echo -e "\n${YELLOW}Add the GPG key for the official Docker repository!${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update

echo -e "\n${YELLOW}apt-cache policy docker-ce${NC}"
apt-cache policy docker-ce

echo -e "\n${YELLOW}Install Docker${NC}"
sudo apt install docker-ce
sudo systemctl status docker --no-pager --full

echo -e "\n${PURPLE}Config Docker${NC}"

echo -e "\n${YELLOW}Set user permissions${NC}"
sudo usermod -aG docker ${USER}

echo -e "\n${YELLOW}Display version${NC}"
docker version

echo -e "\n${GREEN}All done!${NC}"