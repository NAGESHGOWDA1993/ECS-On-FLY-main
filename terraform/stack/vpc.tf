module "vpc" {
  source             = "../modules/vpc"
  app_name           = var.app_name
  app_environment    = var.app_environment
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  aws_region         = var.aws_region
  service_sg_id      = module.ecs.service_sg_id
  alb_sg_id          = module.ecs.alb_sg_id
}

  