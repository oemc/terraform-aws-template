output "vpc_id" {
  value = aws_vpc.omc_vpc.id
}

output "public_subnets" {
  value = [
      aws_subnet.omc_subnet_public_0.id,
      aws_subnet.omc_subnet_public_1.id,
      aws_subnet.omc_subnet_public_2.id
  ]  
}