locals {
  name_sufix = "omc"
  required_tags = {
    User = "omc"
    creation_timestamp = timestamp()
  }
}

resource "aws_vpc" "omc_vpc" {
  cidr_block = var.cidr_block
  tags = merge({ Name = "${local.name_sufix}_vpc" }, local.required_tags)
}

resource "aws_internet_gateway" "omc_igw" {
  vpc_id = aws_vpc.omc_vpc.id
  tags = merge({ Name = "${local.name_sufix}_igw" }, local.required_tags)
}

resource "aws_subnet" "omc_subnet_public" {
  count = length(var.availability_zones)
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = var.availability_zones[count.index]
  tags = merge({ Name = "${local.name_sufix}_subnet_public_${count.index}" }, local.required_tags)
}

resource "aws_subnet" "omc_subnet_private" {
  count = length(var.availability_zones)
  vpc_id     = aws_vpc.omc_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, length(var.availability_zones) + count.index)
  availability_zone = var.availability_zones[count.index]
  tags = merge({ Name = "${local.name_sufix}_subnet_private_${count.index}" }, local.required_tags)
}

resource "aws_route_table" "omc_rt_public" {
  vpc_id = aws_vpc.omc_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.omc_igw.id
  }
  tags = merge({ Name = "${local.name_sufix}_rt_public" }, local.required_tags)
}

resource "aws_route_table" "omc_rt_private" {
  vpc_id = aws_vpc.omc_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.omc_ngw.id
  }
  tags = merge({ Name = "${local.name_sufix}_rt_private" }, local.required_tags)
}

resource "aws_route_table_association" "omc_rta_public" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.omc_subnet_public[count.index].id
  route_table_id = aws_route_table.omc_rt_public.id
}

resource "aws_route_table_association" "omc_rta_private" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.omc_subnet_private[count.index].id
  route_table_id = aws_route_table.omc_rt_private.id
}

resource "aws_nat_gateway" "omc_ngw" {
  allocation_id = aws_eip.omc_eip_ngw.id
  subnet_id     = aws_subnet.omc_subnet_public[0].id
  tags = merge({ Name = "${local.name_sufix}_ngw" }, local.required_tags)
  depends_on = [aws_internet_gateway.omc_igw]
}

resource "aws_eip" "omc_eip_ngw" {
  vpc = true
  tags = merge({ Name = "${local.name_sufix}_eip_ngw" }, local.required_tags)
}