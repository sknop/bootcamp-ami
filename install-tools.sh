#/!bin/bash
 
set -e

sudo apt install -y openjdk-11-jdk

wget -qO - https://packages.confluent.io/deb/7.1/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/7.1 stable main"
sudo add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"

sudo apt update && \
sudo apt install -y confluent-platform && \
sudo apt install -y confluent-security

# some other useful tools
sudo DEBIAN_FRONTEND=noninteractive apt install -y krb5-user
