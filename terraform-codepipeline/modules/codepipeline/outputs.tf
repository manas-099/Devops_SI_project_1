output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.pipeline.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.pipeline.arn
}

output "pipeline_id" {
  description = "ID of the CodePipeline"
  value       = aws_codepipeline.pipeline.id
}

output "cloudwatch_event_rule_name" {
  description = "Name of the CloudWatch event rule (if created)"
  value       = var.source_type == "CodeCommit" ? aws_cloudwatch_event_rule.codecommit_trigger[0].name : null
}