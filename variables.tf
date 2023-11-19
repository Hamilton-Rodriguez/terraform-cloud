variable "virginia_cidr" {
    description = "Virginia CIDR"
    type = string
}

# variable "public_subnet" {
#   description = "Public subnet CIDR"
#   type = string
# }

# variable "private_subnet" {
#     description = "Private subnet CIDR"
#     type = string
# }

variable "subnets" {
  description   =   "List of subnets"
  type = list(string)
}

variable "tags" {
  description = "Project tags"
  type = map(string)
}

variable "sg-ingress-cidr" {
  description = "CIDR for ingress traffic"
  type = string
}

variable "ec2-specs" {
  description = "EC2 instance parameters"
  type = map(string)
}

variable "enable-monitoring" {
  description = "Enable the deployment of a monitoring EC2 instance"
  type = number
}

variable "ingress-ports-list" {
  description = "List of ingress ports"
  type = list(number)
}

variable "access_key" {}
variable "secret_key" {}