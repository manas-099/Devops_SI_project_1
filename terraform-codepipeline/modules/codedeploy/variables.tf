variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "codedeploy_role_arn" {
  description = "ARN of the CodeDeploy service role"
  type        = string
}

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
  default = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
