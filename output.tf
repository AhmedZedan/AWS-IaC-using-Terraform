output "elb_dns_name" {
  value = module.lb[*].elb_dns_name
  }