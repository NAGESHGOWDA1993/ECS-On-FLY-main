# Create ECR repository
module "ecr_repository" {
  source          = "../modules/ecr"
  repository_name = var.repository_name
}

