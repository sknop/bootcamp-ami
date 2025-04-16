#!/bin/bash
 
set -e
version=$1

# Use apt-get instead of apt to avoid the warning about apt not having a stable CLI
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-17-jdk

echo "Installing CP version ${version}"

mkdir -p /etc/apt/keyrings
wget -qO - https://packages.confluent.io/deb/7.9/archive.key | gpg --dearmor | sudo tee /etc/apt/keyrings/confluent.gpg > /dev/null

echo "Types: deb
URIs: https://packages.confluent.io/deb/${version}
Suites: stable
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/confluent.gpg

Types: deb
URIs: https://packages.confluent.io/clients/deb
Suites: $(lsb_release -cs)
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/confluent.gpg" | sudo tee /etc/apt/sources.list.d/confluent-platform.sources > /dev/null

sudo apt-get update && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y confluent-platform && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y confluent-security

# some other useful tools
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y krb5-user

# Remove the sources again, it interferes with the cp-ansible setup
sudo rm /etc/apt/sources.list.d/confluent-platform.sources