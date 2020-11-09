#! /bin/bash
sudo apt update
sudo apt install openjdk-8-jdk -y
sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo apt install software-properties-common
sdo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
