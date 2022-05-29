output "vpc_id" {
  value = aws_vpc.omc_vpc.id
}

output "public_subnets" {
  value = [
      for subnet in aws_subnet.omc_subnet_public :
      subnet.id
  ]  
}