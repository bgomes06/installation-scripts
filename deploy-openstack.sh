#!/bin/bash

sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network

sudo yum --nogpgcheck localinstall -y https://repos.fedorapeople.org/repos/openstack/openstack-stein/rdo-release-stein-3.noarch.rpm
sudo yum install -y centos-release-openstack-stein
sudo yum-config-manager --enable openstack-stein
sudo yum update -y
sudo yum install -y openstack-packstack
sudo packstack --allinone

