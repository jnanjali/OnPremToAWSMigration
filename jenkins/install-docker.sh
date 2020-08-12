#!/bin/bash

# Update the apt package index and install packages to allow apt to use a repository over HTTPS
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common

#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Verify that you now have the key with the fingerprint
sudo apt-key fingerprint 0EBFCD88

# Setup stable docker repository
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

# install docker engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# verify docker daemon is up
docker ps

# add jenkins user to docker group to allow jenkins plugins to invoke docker
sudo usermod -aG docker jenkins

# restart jenkins for the changes to take effect 
systemctl restart jenkins
