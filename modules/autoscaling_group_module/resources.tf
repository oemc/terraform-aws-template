resource "aws_autoscaling_group" "omc_autoscaling_group" {
  min_size             = 1
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = var.launch_configuration
  vpc_zone_identifier  = var.vpc_subnets
}