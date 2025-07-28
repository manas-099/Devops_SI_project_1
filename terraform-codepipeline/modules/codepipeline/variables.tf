variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "codepipeline_role_arn" {
  description = "ARN of the CodePipeline service role"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for artifacts"
  type        = string
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  type        = string
}

variable "deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  type        = string
}

# Source configuration
variable "source_type" {
  description = "Type of source (GitHub or CodeCommit)"
  type        = string
  default     = "GitHub"
  validation {
    condition     = contains(["GitHub", "CodeCommit"], var.source_type)
    error_message = "Source type must be either GitHub or CodeCommit."
  }
}

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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}