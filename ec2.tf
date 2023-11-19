variable "instances" {
  description = "Instances names"
  type = list(string)
  default = [ "apache" ]
}

resource "aws_instance" "Public-EC2-instance" {
  for_each                = toset(var.instances)
  ami                     = var.ec2-specs.ami
  instance_type           = var.ec2-specs.instance_type
  subnet_id               = aws_subnet.public-subnet.id
  key_name                = data.aws_key_pair.practice-6-key.key_name
  vpc_security_group_ids  = [aws_security_group.SG-public-ec2-instance.id]
  user_data               = file("scripts/user-data.sh")
  tags = {
    "Name"                = "${each.value}-${local.sufix}"       # instead of just: each.value
  }
}

resource "aws_instance" "Monitoring-instance" {
  count                   = var.enable-monitoring == 1 ? 1 : 0
  ami                     = var.ec2-specs.ami
  instance_type           = var.ec2-specs.instance_type
  subnet_id               = aws_subnet.public-subnet.id
  key_name                = data.aws_key_pair.practice-6-key.key_name
  vpc_security_group_ids  = [aws_security_group.SG-public-ec2-instance.id]
  user_data               = file("scripts/user-data.sh")
  tags = {
    "Name" = "Monitoring-${local.sufix}"
  }
}