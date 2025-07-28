# CodeDeploy Application
resource "aws_codedeploy_app" "app" {
  compute_platform = "Server"
  name             = "${var.project_name}-app-${var.environment}"

  tags = merge(var.tags, {
    Name        = "${var.project_name}-app-${var.environment}"
    Environment = var.environment
  })
}

# CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "${var.project_name}-deployment-group-${var.environment}"
  service_role_arn      = var.codedeploy_role_arn
  deployment_config_name = var.deployment_config_name

  # Auto Rollback Configuration
  auto_rollback_configuration {
    enabled = var.auto_rollback_enabled
    events  = ["DEPLOYMENT_FAILURE"]
  }

  # Blue/Green Deployment Configuration (only if Auto Scaling Groups are provided)
  dynamic "blue_green_deployment_config" {
    for_each = length(var.auto_scaling_groups) > 0 ? [1] : []
    content {
      terminate_blue_instances_on_deployment_success {
        action                         = "TERMINATE"
        termination_wait_time_in_minutes = 5
      }

      deployment_ready_option {
        action_on_timeout = "CONTINUE_DEPLOYMENT"
      }

      green_fleet_provisioning_option {
        action = "COPY_AUTO_SCALING_GROUP"
      }
    }
  }

  # EC2 Tag Filters (if specified)
  dynamic "ec2_tag_filter" {
    for_each = var.ec2_tag_filters
    content {
      key   = ec2_tag_filter.value.key
      type  = ec2_tag_filter.value.type
      value = ec2_tag_filter.value.value
    }
  }

  tags = var.tags
}

# CloudWatch Log Group for CodeDeploy
resource "aws_cloudwatch_log_group" "codedeploy_log_group" {
  name              = "/aws/codedeploy/${var.project_name}-${var.environment}"
  retention_in_days = 14

  tags = var.tags
}