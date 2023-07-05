output "ecsTaskExecutionRole_arn" {
  value = module.iam_role.ecsTaskExecutionRole_arn
}

output "private_subnet" {
  value = module.vpc.private_subnet
}

output "public_subnet" {
  value = module.vpc.public_subnet
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "service_sg_id" {
  value = module.ecs.service_sg_id
}

output "alb_sg_id" {
  value = module.ecs.alb_sg_id
}