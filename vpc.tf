resource "aws_vpc" "vpc-virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "VPC-Virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.vpc-virginia.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public Subnet-${local.sufix}"
  }  
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.vpc-virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "Private Subnet-${local.sufix}"
  }
  depends_on = [ 
    aws_subnet.public-subnet
   ]
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc-virginia.id
  tags = {
    Name = "IGW VPC Virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public-custom-route-table" {
  vpc_id = aws_vpc.vpc-virginia.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    Name = "Public Custom Route Table-${local.sufix}"
  }
}

resource "aws_route_table_association" "public-custom-route-table-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-custom-route-table.id
}

resource "aws_security_group" "SGG-public-ec2-instance" {
  name        = "Public Instance SG-${local.sufix}"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc-virginia.id

  dynamic "ingress" {
    for_each    = var.ingress-ports-list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks  = [var.sg-ingress-cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }
}
