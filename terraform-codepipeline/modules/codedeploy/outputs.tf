output "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  value       = aws_codedeploy_app.app.name
}

output "codedeploy_app_id" {
  description = "ID of the CodeDeploy application"
  value       = aws_codedeploy_app.app.id
}

output "deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  value       = aws_codedeploy_deployment_group.deployment_group.deployment_group_name
}

output "deployment_group_id" {
  description = "ID of the CodeDeploy deployment group"
  value       = aws_codedeploy_deployment_group.deployment_group.id
}

output "codedeploy_log_group_name" {
  description = "Name of the CloudWatch log group for CodeDeploy"
  value       = aws_cloudwatch_log_group.codedeploy_log_group.name
}