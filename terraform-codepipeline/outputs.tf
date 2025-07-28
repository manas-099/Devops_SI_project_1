# S3 Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket for artifacts"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for artifacts"
  value       = module.s3.bucket_arn
}

# IAM Outputs
output "codepipeline_role_arn" {
  description = "ARN of the CodePipeline service role"
  value       = module.iam.codepipeline_role_arn
}

output "codebuild_role_arn" {
  description = "ARN of the CodeBuild service role"
  value       = module.iam.codebuild_role_arn
}

output "codedeploy_role_arn" {
  description = "ARN of the CodeDeploy service role"
  value       = module.iam.codedeploy_role_arn
}

# CodeBuild Outputs
output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = module.codebuild.codebuild_project_name
}

output "codebuild_project_arn" {
  description = "ARN of the CodeBuild project"
  value       = module.codebuild.codebuild_project_arn
}

# CodeDeploy Outputs
output "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  value       = module.codedeploy.codedeploy_app_name
}

output "deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  value       = module.codedeploy.deployment_group_name
}

# CodePipeline Outputs
output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = module.codepipeline.pipeline_name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = module.codepipeline.pipeline_arn
}

# Additional Information
output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

output "project_name" {
  description = "Name of the project"
  value       = var.project_name
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}