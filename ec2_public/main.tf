resource "aws_instance" "ec2" {
  ami             = var.AMI
  instance_type   = var.Type
  key_name        = var.Key
  subnet_id       = var.subnet_id
  security_groups = [var.SG_id]

  provisioner "local-exec" {
    command = "echo public_IP: ${self.public_ip} >> all-ips.txt"
  }

  provisioner "local-exec" {
    command = "echo private_IP: ${self.private_ip} >> all-ips.txt"
  }

  # nginx installation
  # Exicuting the nginx_proxy.sh file
  provisioner "remote-exec" {
    script = "./${var.script}"

    # Setting up the ssh connection to install the nginx server
    connection {
      type        = var.type
      host        = self.public_ip 
      user        = var.user 
      private_key = file(var.Private_key_path)
    }
  }

  tags = {
    Name = var.ec2-name
  }
}
