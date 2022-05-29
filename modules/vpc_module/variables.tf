variable "cidr_block" {
  default = "192.24.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = [ "us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d" ]
}