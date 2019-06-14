#!/bin/bash

#Run the following script in root mode

# Set Proxy Variable
# To set environment variables through script use 'source' to build that script
export https_proxy="http://10.133.132.165:8181"
export http_proxy="http://10.133.132.165:8181"

# Remove older versions of docker
apt-get remove docker docker-engine docker.io containerd runc

set -e

# Remove any locks held by others
rm /var/lib/apt/lists/lock
rm /var/lib/dpkg/lock

# Install Docker from repository
apt update
apt upgrade

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update
apt upgrade

apt-get install docker-ce docker-ce-cli containerd.io

# Verify docker is installed
docker --version
if [ $? -eq 0 ]
then
    echo
    echo "Docker Installation Successful"
    echo
else
    echo
    echo "Docker Installation Failed"
    echo
fi
