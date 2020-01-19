# Create VPC/Subnet/Security Group/ACL

provider "aws" {
  #  region = "eu-central-1"
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
}

# create the VPC
resource "aws_vpc" "default" { # end resource
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name = var.vpc_name
  }
}

# create the Subnet
resource "aws_subnet" "default_Subnet" { # end resource
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.subnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
  tags = {
    Name = "My VPC Subnet"
  }
}

# Create the Security Group
resource "aws_security_group" "default_Security_Group" { # end resource
  vpc_id      = aws_vpc.default.id
  name        = "My VPC Security Group"
  description = "My VPC Security Group"
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  tags = {
    Name = "My VPC Security Group"
  }
}

# create VPC Network access control list
resource "aws_network_acl" "default_Security_ACL" { # end resource
  vpc_id     = aws_vpc.default.id
  subnet_ids = [aws_subnet.default_Subnet.id]

  # allow port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22
    to_port    = 22
  }

  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }

  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "My VPC ACL"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "default_GW" { # end resource
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "My VPC Internet Gateway"
  }
}

# Create the Route Table
resource "aws_route_table" "default_route_table" { # end resource
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "My VPC Route Table"
  }
}

# Create the Internet Access
resource "aws_route" "default_internet_access" { # end resource
  route_table_id         = aws_route_table.default_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.default_GW.id
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "default_association" { # end resource
  subnet_id      = aws_subnet.default_Subnet.id
  route_table_id = aws_route_table.default_route_table.id
}

# end vpc.tf
