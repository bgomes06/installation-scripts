#!/bin/bash

mkdir -p ~/terraform-openstack/key/

ssh-keygen -t rsa -N '' -f ~/terraform-openstack/key/id_rsa

cp main.tf ~/terraform-openstack/

cd ~/terraform-openstack/

terraform init
terraform apply
