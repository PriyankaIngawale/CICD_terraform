resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = ["subnet-0d033a627d1dccec2", "subnet-07d4718ab80d779bd", "subnet-0ef85e5e35badd593", "subnet-069bbd7352fec80ca"]
 }

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ip-example.arn
  }
}


resource "aws_lb_target_group" "ip-example" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-0d8884f3ae787eb40"
}

output "lb_dns" {
 value = aws_lb.test.dns_name
}