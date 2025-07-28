terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

# S3 Module
module "s3" {
  source = "./modules/s3"

  bucket_name = var.s3_bucket_name
  environment = var.environment
  tags        = var.tags
}

# IAM Module
module "iam" {
  source = "./modules/iam"

  project_name   = var.project_name
  environment    = var.environment
  s3_bucket_arn  = module.s3.bucket_arn
  tags           = var.tags
}

# CodeBuild Module
module "codebuild" {
  source = "./modules/codebuild"

  project_name        = var.project_name
  environment         = var.environment
  codebuild_role_arn  = module.iam.codebuild_role_arn
  s3_bucket_name      = module.s3.bucket_name
  build_timeout       = var.build_timeout
  compute_type        = var.compute_type
  image               = var.build_image
  tags                = var.tags
}

# CodeDeploy Module
module "codedeploy" {
  source = "./modules/codedeploy"

  project_name           = var.project_name
  environment            = var.environment
  codedeploy_role_arn    = module.iam.codedeploy_role_arn
  deployment_config_name = var.deployment_config_name
  auto_rollback_enabled  = var.auto_rollback_enabled
  auto_scaling_groups    = var.auto_scaling_groups
  ec2_tag_filters        = var.ec2_tag_filters
  tags                   = var.tags
}

# CodePipeline Module
module "codepipeline" {
  source = "./modules/codepipeline"

  project_name            = var.project_name
  environment             = var.environment
  codepipeline_role_arn   = module.iam.codepipeline_role_arn
  s3_bucket_name          = module.s3.bucket_name
  codebuild_project_name  = module.codebuild.codebuild_project_name
  codedeploy_app_name     = module.codedeploy.codedeploy_app_name
  deployment_group_name   = module.codedeploy.deployment_group_name
  source_type             = var.source_type
  github_owner            = var.github_owner
  github_repo             = var.github_repo
  github_branch           = var.github_branch
  codecommit_repo_name    = var.codecommit_repo_name
  codecommit_branch       = var.codecommit_branch
  tags                    = var.tags
}