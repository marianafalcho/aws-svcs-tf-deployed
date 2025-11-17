locals {
  success_retention = "7"
  failure_retention = "30"
  }

resource "aws_synthetics_canary" "test" {
  name                     = "${var.project_name}-${var.environment}-uptime"
  artifact_s3_location     = "s3://${var.s3_bucket}/${var.project_name}-${var.environment}/"
  execution_role_arn       = aws_iam_role.cw_synthetic_canaries_role.arn
  handler                  = "pageLoadBlueprint.handler"
  runtime_version          = "syn-nodejs-puppeteer-3.5"
  success_retention_period = local.success_retention
  failure_retention_period = local.failure_retention
  start_canary             = true
  zip_file                 = "scripts-config/${var.project_name}-${var.environment}-uptime.zip"


  vpc_config {
    subnet_ids         = var.subnets
    security_group_ids = [var.security_group_id]

  }

  schedule {
    expression = "rate(1 minute)"
  }
}

resource "aws_cloudwatch_metric_alarm" "test_alarm" {
  alarm_name          = "Synthetics-Alarm-${var.project_name}-${var.environment}-uptime"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  datapoints_to_alarm = "1"
  metric_name         = "Failed requests"
  namespace           = "CloudWatchSynthetics"
  period              = "60"
  threshold           = "2"
  statistic           = "Sum"
  alarm_description   = "This metric monitors ${var.project_name}-${var.environment}-uptime API uptime"
  treat_missing_data  = "breaching"
  alarm_actions       = [aws_sns_topic.service_topic.arn]
  dimensions = {
    CanaryName = "${var.project_name}-${var.environment}-uptime"
  }
}
