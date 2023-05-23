# VPC
variable "vpc-cidr" {}
variable "vpc-name" {}
variable "IGW-name" {}

#Subnet
variable "pub-subnet-cidr" {}
variable "priv-subnet-cidr" {}
variable "map_public_ip" {}
variable "pub-subnet-name" {}
variable "priv-subnet-name" {}
variable "availability_zone" {}

#Route Table
variable "cidr_block_RT" {}
variable "pub-RT_name" {}
variable "priv-RT_name" {}

# Nat Gateway
variable "NAT-GW-name" {}

# Security Group
variable "SG-name" {}

# SG_Rule
variable "Cidr_allow_all" {}
variable "rule_type" {}
variable "ports" {}
variable "protocols" {}

# AMI For EC2
variable "filter1_name" {}
variable "filter1_value" {}
variable "filter2_name" {}
variable "filter2_value" {}
variable "ami_owner" {}

# ec2
variable "pub-ec2-name" {}
variable "priv-ec2-name" {}
variable "Type" {}
variable "Key" {}
variable "user_data_file" {}

# provisioner "file" variables
variable "file_source" {}
variable "destination" {}

#provisioner "remote-exec" variables
variable "inline" {}

#provisioner connection variables
variable "type" {}

# variable "host" {}
variable "user" {}
variable "Private_key_path" {}

# lb Security Group
variable "lb_SG_name" {}
variable "lb_rule_type" {}
variable "lb_ports" {}
variable "lb_protocols" {}

# Load Balancer
variable "lb_name" {}
variable "lb_internal" {}
variable "lb_type" {}
variable "lb_ip_type" {}

# Target Group
variable "lbtg_name" {}
variable "lbtg_port" {}
variable "lbtg_protocol" {}
variable "lbtg_target_type" {}

variable "hk_interval" {}
variable "hk_path" {}
variable "hk_protocol" {}
variable "hk_timeout" {}
variable "hk_healthy_threshold" {}
variable "hk_unhealthy_threshold" {}

#Listener
variable "lis_port" {}
variable "lis_protocol" {}
variable "lis_action_type" {}

variable "TG_port" {}
