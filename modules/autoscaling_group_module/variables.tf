variable "launch_configuration" {
  default = "omc_launch_configuration"
}

variable "vpc_subnets" {
  type = list(string)
}