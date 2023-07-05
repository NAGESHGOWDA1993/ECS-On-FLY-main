# ECR
aws_region      = "eu-west-2"
repository_name = "flask-app"

# VPC zones and subnets 
availability_zones = ["eu-west-2a", "eu-west-2b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]

# these are used for tags
app_name        = "flask-app"
app_environment = "development"
image_tag       = "v1.0.0"
