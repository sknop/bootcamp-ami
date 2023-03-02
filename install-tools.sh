#!/bin/bash
 
set -e
version=$1

# Use apt-get instead of apt to avoid the warning about apt not having a stable CLI
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-17-jdk

echo "Installing CP version ${version}"

wget -qO - https://packages.confluent.io/deb/${version}/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/${version} stable main"
sudo add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"

sudo apt-get update && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y confluent-platform && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y confluent-security

# some other useful tools
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y krb5-user
