#!/bin/bash

systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network

yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-ocata/rdo-release-ocata-3.noarch.rpm
yum install -y centos-release-openstack-ocata
yum-config-manager --enable openstack-ocata
yum update -y
yum install -y openstack-packstack
packstack --allinone

