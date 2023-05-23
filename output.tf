output "elb_dns_name" {
  value = module.pub-lb[*].elb_dns_name
  }

output "ec2_ids" {
  value = [ module.pub-ec2[*].ec2_id, module.priv-ec2[*].ec2_id ]
}