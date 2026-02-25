provider "aws" {
  region = var.aws_region
}

#####################################
# SNS Topic + Email Subscription
#####################################

resource "aws_sns_topic" "alerts" {
  name = "${var.client_name}-${var.environment}-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

#####################################
# CloudWatch Log Group
#####################################

resource "aws_cloudwatch_log_group" "this" {
  name              = "/${var.client_name}/${var.environment}/ec2"
  retention_in_days = 14
}

#####################################
# Local Threshold Map
#####################################

locals {
  thresholds = {
    normal   = 70
    warning  = 80
    critical = 90
  }
}

#####################################
# CPU Alarms (AWS Default Metric)
#####################################

resource "aws_cloudwatch_metric_alarm" "cpu" {
  for_each = local.thresholds

  alarm_name          = "${var.client_name}-cpu-${each.key}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = each.value

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_description = "CPU utilization ${each.key} threshold exceeded (${each.value}%)"

  alarm_actions = [aws_sns_topic.alerts.arn]
}

#####################################
# Memory Alarms (CWAgent Required)
#####################################

resource "aws_cloudwatch_metric_alarm" "memory" {
  for_each = local.thresholds

  alarm_name          = "${var.client_name}-memory-${each.key}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = each.value

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_description = "Memory utilization ${each.key} threshold exceeded (${each.value}%)"

  alarm_actions = [aws_sns_topic.alerts.arn]
}

#####################################
# Disk Alarms (CWAgent Required)
#####################################

resource "aws_cloudwatch_metric_alarm" "disk" {
  for_each = local.thresholds

  alarm_name          = "${var.client_name}-disk-${each.key}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = each.value

  dimensions = {
    InstanceId = var.instance_id
    path       = "/"
    fstype     = var.disk_fstype
  }

  alarm_description = "Disk utilization ${each.key} threshold exceeded (${each.value}%)"

  alarm_actions = [aws_sns_topic.alerts.arn]
}