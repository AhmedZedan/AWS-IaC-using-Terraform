data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = var.filter1_name
        values = var.filter1_value
    }

    filter {
        name   = var.filter2_name
        values = var.filter2_value
    }

    owners = var.ami_owner
}