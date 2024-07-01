resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.log_group_name #"/ecs/orchestrator"
  retention_in_days = var.log_group_qtd_retention #7
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "cpu_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_actions       = [aws_sns_topic.sns_topic.arn]

  dimensions = {
    ClusterName = var.cluster_name
  }
}

resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name #"orchestrator-sns-topic"
}