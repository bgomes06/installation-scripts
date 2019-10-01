provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "openstack" {
  key_name   = "openstack-key"
  public_key = "${file("key/id_rsa.pub")}"
}

resource "aws_security_group" "openstack" {
  name        = "openstack"
  description = "Allow all inbound/outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.85.39.2/32"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_spot_instance_request" "openstack" {
  ami = "ami-d5bf2caa"
  spot_price = "0.07"
  instance_type = "m3.xlarge"
  availability_zone = "us-east-1a"
  wait_for_fulfillment = true
  spot_type = "one-time"
  key_name = "${aws_key_pair.openstack.key_name}"

  security_groups = ["default", "${aws_security_group.openstack.name}"]

  root_block_device {
    volume_size = 40
    delete_on_termination = true
  }

}

output "ip" {
  value = "${aws_spot_instance_request.openstack.public_ip}"
}
