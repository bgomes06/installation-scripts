#!/bin/bash

sudo amazon-linux-extras install docker -y

sleep 2

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -a -G docker ec2-user

sleep 2

sudo curl -L https://github.com/docker/compose/releases/download/1.25.0-rc2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker -v
docker-compose -v
