resource "aws_instance" "application" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  #VPC Subnet
  subnet_id = aws_subnet.main-private-1.id

  #Security Group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  #SSH key
  key_name = var.AWS_KEY

  tags = {
    Name = "Instance-1",
    Owner = "ANIRBAN"
  }
}
