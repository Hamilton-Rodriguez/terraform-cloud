virginia_cidr = "10.10.0.0/16"
# public_subnet   =   "10.10.0.0/24"
# private_subnet  =   "10.10.1.0/24"

subnets = [ "10.10.0.0/24","10.10.1.0/24"]

tags = {
  "env" = "DEV"
  "project" =  "cerberus"
  "region" = "virginia"
  "owner" = "Hamilton"
  "IAC-version" = "1.6.3"
}

sg-ingress-cidr = "0.0.0.0/0"

ec2-specs = {
  "ami" = "ami-01eccbf80522b562b"
  "instance_type" = "t2.micro"
}

enable-monitoring = 0

ingress-ports-list = [ 22,80,443 ]
