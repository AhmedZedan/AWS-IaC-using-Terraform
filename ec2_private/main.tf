resource "aws_instance" "ec2" {
  ami             = var.AMI
  instance_type   = var.Type
  key_name        = var.Key
  subnet_id       = var.subnet_id
  security_groups = [var.SG_id]
  user_data       = var.user_data_file
  # <<-EOF
  # #!/bin/bash
  # echo "*** Installing apache2"
  # sudo apt update -y
  # sudo apt install apache2 -y
  # echo "*** Completed Installing apache2"
  # EOF

  provisioner "local-exec" {
    command = "echo public_IP: ${self.public_ip} >> all-ips.txt"
  }

  provisioner "local-exec" {
    command = "echo private_IP: ${self.private_ip} >> all-ips.txt"
  }

  tags = {
    Name = var.ec2-name
  }

}