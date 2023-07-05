module "iam_role" {
  source          = "../modules/iam"
  app_name        = var.app_name
  app_environment = var.app_environment
}

 