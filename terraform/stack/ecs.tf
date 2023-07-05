module "ecs" {
  source                   = "../modules/ecs"
  app_name                 = var.app_name
  app_environment          = var.app_environment
  image_tag                = var.image_tag
  repository_name          = var.repository_name
  ecsTaskExecutionRole_arn = module.iam_role.ecsTaskExecutionRole_arn
  aws_region               = var.aws_region
  private_subnet           = module.vpc.private_subnet
  public_subnet            = module.vpc.public_subnet
  vpc_id                   = module.vpc.vpc_id
}

 