variable "AMI" {}
variable "ec2-name" {}
variable "Type" {}
variable "Key" {}
variable "subnet_id" {}
variable "SG_id" {}

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
