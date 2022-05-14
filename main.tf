terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}


resource "aws_vpc" "omc_vpc" {
  cidr_block = "192.24.0.0/16"
  tags = {
    "Name" = "omc_vpc"
    "User" = "omc"
  }
}

resource "aws_internet_gateway" "omc_igw" {
  vpc_id = aws_vpc.omc_vpc.id
  tags = {
    "Name" = "omc_igw"
    "User" = "omc"
  }
}

resource "aws_subnet" "omc_subnet_public_0" {
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = "192.24.0.0/24"
  tags = {
    "Name" = "omc_subnet_public_0"
    "User" = "omc"
  }
}

resource "aws_subnet" "omc_subnet_public_1" {
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = "192.24.1.0/24"
  tags = {
    "Name" = "omc_subnet_public_1"
    "User" = "omc"
  }
}

resource "aws_subnet" "omc_subnet_public_2" {
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = "192.24.2.0/24"
  tags = {
    "Name" = "omc_subnet_public_2"
    "User" = "omc"
  }
}

resource "aws_subnet" "omc_subnet_private_0" {
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = "192.24.3.0/24"
  tags = {
    "Name" = "omc_subnet_private_0"
    "User" = "omc"
  }
}

resource "aws_subnet" "omc_subnet_private_1" {
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = "192.24.4.0/24"
  tags = {
    "Name" = "omc_subnet_private_1"
    "User" = "omc"
  }
}

resource "aws_subnet" "omc_subnet_private_2" {
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = "192.24.5.0/24"
  tags = {
    "Name" = "omc_subnet_private_2"
    "User" = "omc"
  }
}

resource "aws_route_table" "omc_rt_public" {
  vpc_id = aws_vpc.omc_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.omc_igw.id
  }
  tags = {
    "Name" = "omc_rt_public"
    "User" = "omc"
  }
}

resource "aws_route_table" "omc_rt_private" {
  vpc_id = aws_vpc.omc_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.omc_ngw.id
  }
  tags = {
    "Name" = "omc_rt_private"
    "User" = "omc"
  }
}

resource "aws_nat_gateway" "omc_ngw" {
  allocation_id = aws_eip.omc_eip_ngw.id
  subnet_id     = aws_subnet.omc_subnet_public_0.id
  tags = {
    "Name" = "omc_ngw"
    "User" = "omc"
  }
  depends_on = [aws_internet_gateway.omc_igw]
}

resource "aws_eip" "omc_eip_ngw" {
  vpc = true
  tags = {
    "Name" = "omc_eip_ngw"
    "User" = "omc"
  }
}