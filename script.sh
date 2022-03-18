#!/bin/bash
echo Helloo World
sudo apt -y install openjdk-8-jdk
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y
sudo apt update -y
sudo apt install docker-ce -y
sudo docker run -p 80:8080 tsv1982/petclinic



# sudo apt update -y
# sudo apt install python3-pip -y
# sudo apt install python3-pip -y




