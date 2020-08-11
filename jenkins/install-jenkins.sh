#!/bin/bash

# ssh to the Ubuntu VM running on EC2
ssh -i "testingtesting.pem" ubuntu@xxx.xxx.xx.xxx.us-xxxx-2.compute.amazonaws.com

# Install JDK
sudo apt install default-jre
sudo apt install openjdk-8-jdk

# update to Debian stable apt repository
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update


# Install jenkins and restart 
sudo apt install jenkins
sudo systemctl start jenkins

# Allow firewall port 8080, default Jenkins port
sudo ufw allow 8080

# Restart Jenkins again
sudo systemctl restart jenkins

# Find the admin passowrd
cat /var/lib/jenkins/secrets/initialAdminPassword

