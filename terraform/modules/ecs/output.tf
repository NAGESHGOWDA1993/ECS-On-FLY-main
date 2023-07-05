output "service_sg_id" {
  value = aws_security_group.service_security_group.id
}

output "alb_sg_id" {
  value = aws_security_group.load_balancer_security_group.id
}