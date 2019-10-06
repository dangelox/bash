#!/bin/bash 

###################################################################
#Script Name	: install_openJDK.sh
#Description	: Install openjdk 8 on Ubuntu linux.
#                 JRE is included in the JDK package. If you need 
#                 only JRE, install the default-jre package:
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
#echo -e "\n${YELLOW}Text in color!${NC}"

echo -e "\n${YELLOW}Update OS${NC}"
sudo apt update

echo -e "\n${YELLOW}Install opnejdk 8${NC}"
sudo apt install openjdk-8-jdk -y

echo -e "\n${YELLOW}Display install version${NC}"
java -version

echo -e "\n${GREEN}All done!${NC}"