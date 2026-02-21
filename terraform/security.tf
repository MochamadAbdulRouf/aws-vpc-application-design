resource "aws_network_acl" "db_nacl" {
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.database_subnets


  ingress {
    rule_no    = 100
    protocol   = "tcp"
    cidr_block = "10.0.4.0/24"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
  }
  ingress {
    rule_no    = 110
    protocol   = "tcp"
    cidr_block = "10.0.5.0/24"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
  }
  ingress {
    rule_no    = 120
    protocol   = "tcp"
    cidr_block = "10.0.6.0/24"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
  }

  egress {
    rule_no    = 100
    protocol   = "tcp"
    cidr_block = "10.0.7.0/24"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
  }
  egress {
    rule_no    = 110
    protocol   = "tcp"
    cidr_block = "10.0.8.0/24"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
  }

  egress {
    rule_no    = 120
    protocol   = "tcp"
    cidr_block = "10.0.9.0/24"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
  }

  tags = {
    Name = "Prod-DB-NACL"
  }
}

resource "aws_security_group" "vpce_sg" {
  name        = "vpce_sg"
  description = "Allow TLS inbound traffic for vpc EndPoints"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.us-west-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.vpc.private_route_table_ids
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-west-2.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = slice(module.vpc.private_subnets, 0, 3)
  security_group_ids  = [aws_security_group.vpce_sg.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-west-2.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = slice(module.vpc.private_subnets, 0, 3)
  security_group_ids  = [aws_security_group.vpce_sg.id]
  private_dns_enabled = true
}
