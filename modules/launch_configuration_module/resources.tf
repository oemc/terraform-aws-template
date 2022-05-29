locals {
  name_sufix = "omc"
  required_tags = {
    User = "omc"
    creation_timestamp = timestamp()
  }
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = [ "amazon" ]
  }

  filter {
    name   = "name"
    values = [ "amzn2-ami-hvm*" ]
  }

  owners = [ "amazon" ]
}

resource "aws_security_group" "omc_security_group" {
  vpc_id = var.vpc_id

  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = merge({ Name = "${local.name_sufix}_security_group" }, local.required_tags)
}

resource "aws_launch_configuration" "omc_launch_configuration" {
  name = "${local.name_sufix}_launch_configuration"
  image_id = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  user_data = file("${path.module}/user_data.sh")
  security_groups = [ aws_security_group.omc_security_group.id ]

  lifecycle {
    create_before_destroy = true
  }
}

