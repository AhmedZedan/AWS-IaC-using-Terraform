resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = var.lb_security_groups
  subnets            = var.lb_subnets
  ip_address_type    = var.lb_ip_type

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "lb_TG" {
  name        = var.lbtg_name
  port        = var.lbtg_port
  protocol    = var.lbtg_protocol
  target_type = var.lbtg_target_type
  vpc_id      = var.vpc_id

  health_check {
    interval               = var.hk_interval
    path                   = var.hk_path
    protocol               = var.hk_protocol
    timeout                = var.hk_timeout
    healthy_threshold      = var.hk_healthy_threshold
    unhealthy_threshold    = var.hk_unhealthy_threshold
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn  = aws_lb.lb.arn
  port               = var.lis_port
  protocol           = var.lis_protocol

  default_action {
    type             = var.lis_action_type
    target_group_arn = aws_lb_target_group.lb_TG.arn
  }
}

resource "aws_lb_target_group_attachment" "lb_TG_attachment" {
  count              = length(var.instances_id)
  target_group_arn   = aws_lb_target_group.lb_TG.arn
  target_id          = var.instances_id[count.index]
  port               = var.TG_port
}