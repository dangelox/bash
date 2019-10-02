#!/bin/bash 

###################################################################
#Script Name	: linux_install_protobuf.sh
#Description	: Install protocol buffer compiler on Linux.
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

echo -e "\n${YELLOW}Download protoc-3.9.2 version${NC}"
curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.9.2/protoc-3.9.2-linux-aarch_64.zip

echo -e "\n${YELLOW}Unzip downloaded file${NC}"
unzip protoc-3.9.2-linux-aarch_64.zip -d protoc3

echo -e "\n${YELLOW}Move protoc to /usr/local/bin/${NC}"
sudo mv protoc3/bin/* /usr/local/bin/

echo -e "\n${YELLOW}Move protoc3/include to /usr/local/include/${NC}"
sudo mv protoc3/include/* /usr/local/include/

echo -e "\n${YELLOW}Change owner${NC}"
sudo chown $USER /usr/local/bin/protoc
sudo chown -R $USER /usr/local/include/google

echo -e "\n${GREEN}All done!${NC}"