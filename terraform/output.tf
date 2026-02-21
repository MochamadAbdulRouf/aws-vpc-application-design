output "vpc_name" {
  description = "output from vpc"
  value = module.vpc.default_vpc_id
}

output "nacl_ouput" {
  description = "ouput from nacl"
  value = aws_security_group.vpce_sg
}

output "vpc_endpoint_s3" {
  description = "output from vpc endpoint s3"
  value = aws_vpc_endpoint.s3
}

output "vpc_endpoint_sm" {
  description = "output from vpc endpoint secret manager"
  value = aws_vpc_endpoint.secretsmanager
}

output "vpc_endpoint_logs" {
  description = "output from vpc endpoint cloud watch"
  value = aws_vpc_endpoint.cloudwatch
}
