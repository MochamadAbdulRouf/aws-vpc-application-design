resource "aws_network_acl" "db_nacl" {
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.database_subnets


  ingress  {
    rule_no = 100
    protocol = "tcp"
    cidr_block = "10.0.4.0/24"
    from_port = 3306
    to_port = 3306
    action = "allow"
  }
  ingress  {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.5.0/24"
    from_port = 3306
    to_port = 3306
    action = "allow"
  }
  ingress  {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.6.0/24"
    from_port = 3306
    to_port = 3306
    action = allow
  }

  egress {
    rule_no = 100
    protocol = "tcp"
    cidr_block = "10.0.7.0/24"
    from_port = 3306
    to_port = 3306
    action = allow
  }
  egress {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.8.0/24"
    from_port = 3306
    to_port = 3306
    action = allow
  }

  egress  {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.9.0/24"
    from_port = 3306
    to_port = 3306
    action = allow
  }


}
