# Load Balancer
variable "lb_name" {}
variable "lb_internal" {}
variable "lb_type" {}
variable "lb_security_groups" {}
variable "lb_subnets" {}
variable "lb_ip_type" {}

# Target Group
variable "lbtg_name" {}
variable "lbtg_port" {}
variable "lbtg_protocol" {}
variable "lbtg_target_type" {}
variable "vpc_id" {}
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

# Target Group attachment
variable "instances_id" {}
variable "TG_port" {}