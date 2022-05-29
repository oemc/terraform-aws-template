locals {
  name_sufix = "omc"
}

resource "aws_autoscaling_group" "omc_autoscaling_group" {
  min_size             = 1
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = var.launch_configuration
  vpc_zone_identifier  = var.vpc_subnets
  
  tag {
    key = "Name"
    value = "${local.name_sufix}_auto_scaling_group_instance"
    propagate_at_launch = true
  }

  tag {
    key = "User"
    value = "omc"
    propagate_at_launch = true
  }

  tag {
    key = "creation_timestamp"
    value = timestamp()
    propagate_at_launch = true
  }
}