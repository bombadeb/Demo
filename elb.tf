resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = [aws_subnet.main-public-1.id]
  security_groups = [aws_security_group.allow-http.id]
  listener {
    instance_port     = 8080
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
  
  instances                   = [aws_instance.application.id]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "allow-http",
    Owner = "gs-1074",
    Practice = "CIS",
    Project = "POC",
    Purpose = "Project POC",
    Duration = "1 Week" 
  }
}
