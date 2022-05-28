terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "omc_vpc" {
  source = "./modules/vpc_module"
  cidr_block = "192.24.0.0/16"
}

module "omc_launch_configuration" {
  source = "./modules/launch_configuration_module"
  vpc_id = module.omc_vpc.vpc_id
}

module "omc_autoscalling_group" {
  source = "./modules/autoscaling_group_module"
  launch_configuration = module.omc_launch_configuration.launch_configuration_name
  vpc_subnets = module.omc_vpc.public_subnets
}