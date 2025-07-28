output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.build_project.name
}

output "codebuild_project_arn" {
  description = "ARN of the CodeBuild project"
  value       = aws_codebuild_project.build_project.arn
}

output "codebuild_log_group_name" {
  description = "Name of the CloudWatch log group for CodeBuild"
  value       = aws_cloudwatch_log_group.codebuild_log_group.name
}