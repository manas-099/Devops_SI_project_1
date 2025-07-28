# CodePipeline
resource "aws_codepipeline" "pipeline" {
  name     = "${var.project_name}-pipeline-${var.environment}"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = var.source_type == "GitHub" ? "ThirdParty" : "AWS"
      provider         = var.source_type == "GitHub" ? "GitHub" : "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = var.source_type == "GitHub" ? {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = var.github_branch
        OAuthToken = "{{resolve:secretsmanager:github-token:SecretString:token}}"
      } : {
        RepositoryName = var.codecommit_repo_name
        BranchName     = var.codecommit_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName     = var.codedeploy_app_name
        DeploymentGroupName = var.deployment_group_name
      }
    }
  }

  tags = merge(var.tags, {
    Name        = "${var.project_name}-pipeline-${var.environment}"
    Environment = var.environment
  })
}

# CloudWatch Event Rule for automatic pipeline triggering (for CodeCommit)
resource "aws_cloudwatch_event_rule" "codecommit_trigger" {
  count = var.source_type == "CodeCommit" ? 1 : 0

  name        = "${var.project_name}-codecommit-trigger-${var.environment}"
  description = "Trigger pipeline on CodeCommit push"

  event_pattern = jsonencode({
    source      = ["aws.codecommit"]
    detail-type = ["CodeCommit Repository State Change"]
    resources   = ["arn:aws:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.codecommit_repo_name}"]
    detail = {
      event         = ["referenceCreated", "referenceUpdated"]
      referenceType = ["branch"]
      referenceName = [var.codecommit_branch]
    }
  })

  tags = var.tags
}

# CloudWatch Event Target
resource "aws_cloudwatch_event_target" "codepipeline_target" {
  count = var.source_type == "CodeCommit" ? 1 : 0

  rule      = aws_cloudwatch_event_rule.codecommit_trigger[0].name
  target_id = "CodePipelineTarget"
  arn       = aws_codepipeline.pipeline.arn
  role_arn  = var.codepipeline_role_arn
}

# Data sources
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}