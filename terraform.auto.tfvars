# VPC
vpc-cidr = "10.0.0.0/16"
vpc-name = "zedan-vpc"
IGW-name = "zedan-IGW"

#Subnet
pub-subnet-cidr      = ["10.0.0.0/24", "10.0.2.0/24"]
priv-subnet-cidr     = ["10.0.1.0/24", "10.0.3.0/24"]
map_public_ip        = [true, true]
pub-subnet-name      = ["pub-sub-1","pub-sub-2"]
priv-subnet-name     = ["priv-sub-1","priv-sub-2"]
availability_zone    = ["us-east-1a", "us-east-1b"]

#Route Table
cidr_block_RT        = ["0.0.0.0/0", "0.0.0.0/0"]
pub-RT_name          = ["pub_RT_1", "pub_RT_2"]
priv-RT_name         = ["priv_RT_1", "priv_RT_2"]

# Nat Gateway
NAT-GW-name = "zedan-Nat-GW"

# Security Group
SG-name = "ec2-SG"


# SG_Rule
rule_type           = ["ingress", "ingress", "egress"]
ports               = [22, 80, 0]
protocols           = ["tcp", "tcp", "-1"]
Cidr_allow_all      = ["0.0.0.0/0"]

# AMI For EC2
filter1_name        = "name"
filter1_value       = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
filter2_name        = "virtualization-type"
filter2_value       = ["hvm"]
ami_owner           = ["099720109477"]

# ec2
Type                = "t2.micro"
pub-ec2-name        = ["ec2-pub-1", "ec2-pub-2"]
priv-ec2-name       = ["ec2-priv-1", "ec2-priv-2"]
Key                 = "zedan"
user_data_file      = "./apache2.sh"

# provisioner "file" variables
file_source         = "nginx.sh"
destination         = "/tmp/nginx.sh"

# provisioner "remote-exec" variables
inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]

# provisioner connection variables
type = "ssh"

# host = "self.public_ip"
user                   = "ubuntu"
Private_key_path       = "/home/zedan/Downloads/zedan.pem"

# lb Security Group
lb_SG_name                 = "lb_SG"
lb_rule_type               = ["ingress", "egress"]
lb_ports                   = [80, 0]
lb_protocols               = ["tcp", "-1"]

# lb Variables
lb_name                    = ["pub-lb", "priv-lb"]
lb_internal                = [false, true]
lb_type                    = "application"
lb_ip_type                 = "ipv4"

# Target group Variables
lbtg_name                  = ["pub-lb-TG", "priv-lb-TG"]
lbtg_port                  = 80
lbtg_protocol              = "HTTP"
lbtg_target_type           = "instance"

hk_interval                = 10
hk_path                    = "/"
hk_protocol                = "HTTP"
hk_timeout                 = 5
hk_healthy_threshold       = 5
hk_unhealthy_threshold     = 2

#lb Listener Variables
lis_port                   = 80
lis_protocol               = "HTTP"
lis_action_type            = "forward"

TG_port                    = 80
