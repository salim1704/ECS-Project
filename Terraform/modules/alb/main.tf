resource "aws_lb" "this" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet

  tags = {
    Name = "app-load-balancer"
  }
  
}