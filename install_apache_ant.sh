#!/bin/bash 

###################################################################
#Script Name	: install_apache_ant.sh
#Description	: Install Apache Ant on Ubuntu.
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
echo -e "\n${PURPLE}Install Apache Ant${NC}"

echo -e "\n${YELLOW}Update OS${NC}"
sudo apt update

echo -e "\n${YELLOW}Download apache-ant  latest version${NC}"
wget http://apache.cs.utah.edu//ant/binaries/apache-ant-1.10.7-bin.tar.gz

echo -e "\n${YELLOW}Extract tar.gz file${NC}"
sudo tar xf apache-ant-1.10.7-bin.tar.gz -C /usr/local/

echo -e "\n${YELLOW}Navigate to the extracted directory and rename the file${NC}"
mv /usr/local/apache-ant-1.10.7 /usr/local/apache-ant

echo -e "\n${YELLOW}Create a soft link${NC}"
ln -s /usr/local/apache-ant /usr/local/ant

echo -e "\n${YELLOW}create Environment Variables for Apache Ant${NC}"
sudo touch /etc/profile.d/ant.sh
sudo cat >>/etc/profile.d/ant.sh<<EOF
export ANT_HOME=/usr/local/ant
export PATH=${ANT_HOME}/bin:${PATH}
EOF
source /etc/profile

echo -e "\n${YELLOW}Display Apache Ant version${NC}"
ant -version

echo -e "\n${GREEN}All done!${NC}"