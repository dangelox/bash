#!/bin/bash 

###################################################################
#Script Name	: install_wildfly.sh
#Description	: Install WildFly (JBoss) on Ubuntu Linux.
#                 Based on https://vitux.com/install-and-configure-wildfly-jboss-on-ubuntu/
#				  Missing - configuration of console @ port 9990	
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

echo -e "\n${PURPLE}Install and Configure WildFly${NC}"

echo -e "\n${YELLOW}Update OS${NC}"
sudo apt-get update

echo -e "\n${YELLOW}Create a user and group for WildFly${NC}"
sudo groupadd -r wildfly
sudo useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly

echo -e "\n${YELLOW}Download the Wildfly Installation file${NC}"
Version_Number=16.0.0.Final
wget https://download.jboss.org/wildfly/$Version_Number/wildfly-$Version_Number.tar.gz -P /tmp

echo -e "\n${YELLOW}Extract the WildFly tar.gz file to /opt folder${NC}"
sudo tar xf /tmp/wildfly-$Version_Number.tar.gz -C /opt/

echo -e "\n${YELLOW}Create a symbolic link to point to the WildFly installation directory${NC}"
sudo ln -s /opt/wildfly-$Version_Number /opt/wildfly

echo -e "\n${YELLOW}Give access to WildFly group and user${NC}"
sudo chown -RH wildfly: /opt/wildfly

echo -e "\n${YELLOW}Configure Wildfly to be run as a service${NC}"
sudo mkdir -p /etc/wildfly
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo touch /etc/wildfly/wildfly.conf
sudo cat >>/etc/wildfly/wildfly.conf<<EOF
# The configuration you want to run
WILDFLY_CONFIG=standalone.xml

# The mode you want to run
WILDFLY_MODE=standalone

# The address to bind to
WILDFLY_BIND=0.0.0.0

# The address console to bind to
WILDFLY_CONSOLE_BIND=0.0.0.0
EOF
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo sh -c 'chmod +x /opt/wildfly/bin/*.sh'
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo systemctl daemon-reload

echo -e "\n${YELLOW}Start the WildFly service${NC}"
sudo systemctl start wildfly
sudo systemctl status wildfly --no-pager --full
sudo systemctl enable wildfly

echo -e "\n${PURPLE}Configure WildFly${NC}"

echo -e "\n${YELLOW}Allow traffic on port 8080${NC}"
sudo ufw allow 8080/tcp
sudo ufw allow 9990/tcp

echo -e "\n${YELLOW}Create a WildFly Administrator${NC}"
sudo /opt/wildfly/bin/add-user.sh

echo -e "\n${YELLOW}Verify the successful setup of WindFly${NC}"
curl http://localhost:8080

echo -e "\n${PURPLE}Configure WildFly Admin Console${NC}"
echo -e "\n${RED}Script needs updating. Perform this manually.${NC}"
echo -e "\n${RED}Refer to https://vitux.com/install-and-configure-wildfly-jboss-on-ubuntu/${NC}"

echo -e "\n${GREEN}All done!${NC}"

# <secret value="TWlzc2lvblg="