variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-cicd-project"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# S3 Configuration
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for CodePipeline artifacts (must be globally unique)"
  type        = string
}

# Source Configuration
variable "source_type" {
  description = "Type of source (GitHub or CodeCommit)"
  type        = string
  default     = "GitHub"
  validation {
    condition     = contains(["GitHub", "CodeCommit"], var.source_type)
    error_message = "Source type must be either GitHub or CodeCommit."
  }
}

# GitHub Configuration (if using GitHub)
variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "GitHub branch name"
  type        = string
  default     = "main"
}

# CodeCommit Configuration (if using CodeCommit)
variable "codecommit_repo_name" {
  description = "CodeCommit repository name"
  type        = string
  default     = ""
}

variable "codecommit_branch" {
  description = "CodeCommit branch name"
  type        = string
  default     = "main"
}

# CodeBuild Configuration
variable "build_timeout" {
  description = "Build timeout in minutes"
  type        = number
  default     = 60
}

variable "compute_type" {
  description = "CodeBuild compute type"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "CodeBuild Docker image"
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

# CodeDeploy Configuration
variable "deployment_config_name" {
  description = "CodeDeploy deployment configuration"
  type        = string
  default     = "CodeDeployDefault.AllAtOnceAutoScaling"
}

variable "auto_rollback_enabled" {
  description = "Enable automatic rollback on deployment failure"
  type        = bool
  default     = true
}

variable "auto_scaling_groups" {
  description = "List of Auto Scaling group names for deployment"
  type        = list(string)
  default     = []
}

variable "ec2_tag_filters" {
  description = "EC2 tag filters for deployment group"
  type = list(object({
    key   = string
    type  = string
    value = string
  }))
  default = [
    {
      key   = "Environment"
      type  = "KEY_AND_VALUE"
      value = "dev"
    }
  ]
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "CICD-Pipeline"
    ManagedBy   = "Terraform"
  }
}