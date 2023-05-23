provider "aws" {
  profile = "default"
}

module "vpc" {
  source   = "./vpc"
  vpc-cidr = var.vpc-cidr
  vpc-name = var.vpc-name
  IGW-name = var.IGW-name
}


module "pub-subnet" {
	source            = "./subnet"
	count             = length(var.pub-subnet-cidr)
	
	# for subnet
	vpc-id            = module.vpc.vpc_id
	subnet-cidr       = var.pub-subnet-cidr[count.index]
  availability_zone = var.availability_zone[count.index]
	map_public_ip     = var.map_public_ip[count.index]
	subnet-name       = var.pub-subnet-name[count.index]
	
	# for route table
	cidr_block_RT     = var.cidr_block_RT[count.index]
	gateway_id        = module.vpc.IGW_id
	RT_name           = var.pub-RT_name[count.index]
}

module "priv-subnet" {
	source            = "./subnet"
	count             = length(var.priv-subnet-cidr)
	
	# for subnet
	vpc-id            = module.vpc.vpc_id
	subnet-cidr       = var.priv-subnet-cidr[count.index]
  availability_zone = var.availability_zone[count.index]
	subnet-name       = var.priv-subnet-name[count.index]
	
	# for route table
	cidr_block_RT     = var.cidr_block_RT[count.index]
	gateway_id        = module.nat-GW.natGW_id
	RT_name           = var.priv-RT_name[count.index]
}

module "nat-GW" {
  source      = "./natGW"
  subnet_id   = module.pub-subnet[0].sub_id
  NAT-GW-name = var.NAT-GW-name
  depends_on  = [ module.vpc.IGW ]
}


module "ec2_SG" {
  source   = "./Security_group"
  vpc_id   = module.vpc.vpc_id
  SG-name  = var.SG-name
}

module "ec2_SG_rules" {
  source            = "./SG_rule"
  count             = length(var.rule_type)
  type              = var.rule_type[count.index]
  from_port         = var.ports[count.index]
  to_port           = var.ports[count.index]
  protocols         = var.protocols[count.index] 
  Cidr_allow_all    = var.Cidr_allow_all
  SG_id             = module.ec2_SG.SG_id
}

module "ami" {
  source         = "./AMI"
  filter1_name   = var.filter1_name
  filter1_value  = var.filter1_value
  filter2_name   = var.filter2_name
  filter2_value  = var.filter2_value
  ami_owner      = var.ami_owner 
}

module "pub-ec2" {
  source              = "./ec2_public"
  count               = length(var.pub-ec2-name)
  AMI                 = module.ami.ami_img_id
  Type                = var.Type
  Key                 = var.Key
  ec2-name            = var.pub-ec2-name[count.index]
  subnet_id           = module.pub-subnet[count.index].sub_id
  SG_id               = module.ec2_SG.SG_id

  # provisioner "file" variables
  file_source         = var.file_source
  destination         = var.destination

  #provisioner "remote-exec" variables
  inline              = var.inline

  #provisioner connection variables
  type                = var.type
  user                = var.user
  Private_key_path    = var.Private_key_path

}

module "priv-ec2" {
  source         = "./ec2_private"
  count          = length(var.priv-ec2-name)
  AMI            = module.ami.ami_img_id
  Type           = var.Type
  Key            = var.Key
  ec2-name       = var.priv-ec2-name[count.index]
  subnet_id      = module.priv-subnet[count.index].sub_id
  SG_id          = module.ec2_SG.SG_id
  user_data_file = file(var.user_data_file)
}

module "lb_SG" {
  source  = "./Security_group"
  vpc_id  = module.vpc.vpc_id
  SG-name = var.lb_SG_name
}

module "lb_SG_rules" {
  source            = "./SG_rule"
  count             = length(var.lb_rule_type)
  type              = var.lb_rule_type[count.index]
  from_port         = var.lb_ports[count.index]
  to_port           = var.lb_ports[count.index]
  protocols         = var.lb_protocols[count.index] 
  Cidr_allow_all    = var.Cidr_allow_all
  SG_id             = module.lb_SG.SG_id
}

module "pub-lb" {
  source                            = "./load_balancer"

  # lb Variables
  lb_name                           = var.lb_name[0]
  lb_internal                       = var.lb_internal[0]
  lb_type                           = var.lb_type
  lb_security_groups                = [module.lb_SG.SG_id]
  lb_subnets                        = module.pub-subnet[*].sub_id
  lb_ip_type                        = var.lb_ip_type

  # Target group Variables
  lbtg_name                         = var.lbtg_name[0]
  lbtg_port                         = var.lbtg_port
  lbtg_protocol                     = var.lbtg_protocol
  lbtg_target_type                  = var.lbtg_target_type
  vpc_id                            = module.vpc.vpc_id

  hk_interval                       = var.hk_interval
  hk_path                           = var.hk_path
  hk_protocol                       = var.hk_protocol
  hk_timeout                        = var.hk_timeout
  hk_healthy_threshold              = var.hk_healthy_threshold
  hk_unhealthy_threshold            = var.hk_unhealthy_threshold

  #lb Listener Variables            =
  lis_port                          = var.lis_port
  lis_protocol                      = var.lis_protocol
  lis_action_type                   = var.lis_action_type

  # lb target group attachment Variables
  instances_id                      = module.pub-ec2[*].ec2_id
  TG_port                           = var.TG_port
}

module "priv-lb" {
  source                            = "./load_balancer"
  
  # lb Variables
  lb_name                           = var.lb_name[1]
  lb_internal                       = var.lb_internal[1]
  lb_type                           = var.lb_type
  lb_security_groups                = [module.lb_SG.SG_id]
  lb_subnets                        = module.priv-subnet[*].sub_id
  lb_ip_type                        = var.lb_ip_type

  # Target group Variables
  lbtg_name                         = var.lbtg_name[1]
  lbtg_port                         = var.lbtg_port
  lbtg_protocol                     = var.lbtg_protocol
  lbtg_target_type                  = var.lbtg_target_type
  vpc_id                            = module.vpc.vpc_id

  hk_interval                       = var.hk_interval
  hk_path                           = var.hk_path
  hk_protocol                       = var.hk_protocol
  hk_timeout                        = var.hk_timeout
  hk_healthy_threshold              = var.hk_healthy_threshold
  hk_unhealthy_threshold            = var.hk_unhealthy_threshold

  #lb Listener Variables            =
  lis_port                          = var.lis_port
  lis_protocol                      = var.lis_protocol
  lis_action_type                   = var.lis_action_type

  # lb target group attachment Variables
  instances_id                      = module.priv-ec2[*].ec2_id
  TG_port                           = var.TG_port
}