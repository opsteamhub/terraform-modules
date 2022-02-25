
resource "aws_launch_configuration" "lc" {
  name_prefix          = join("-", ["lc", var.environment, var.name])
  image_id             = var.image_id
  iam_instance_profile = var.iam_instance_profile

  instance_type     = var.instance_type
  enable_monitoring = "true"
  key_name          = var.key_name

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = "true"
  }

  security_groups = [var.security_group]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = join("-", ["asg", var.environment, var.name])

  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier  = var.subnets

  max_size         = var.max_size
  desired_capacity = var.desired_capacity != "" ? var.desired_capacity : var.min_size
  min_size         = var.min_size
  default_cooldown = 180

  wait_for_capacity_timeout = 0
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  min_elb_capacity          = 2

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  force_delete              = true

  target_group_arns = var.target_group_arns
  load_balancers    = var.loadbalancer

  enabled_metrics     = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  metrics_granularity = "1Minute"

  termination_policies = ["OldestInstance", "OldestLaunchConfiguration", "ClosestToNextInstanceHour", "OldestLaunchTemplate"]

  tag {
    key                 = "Name"
    value               = join("-", [var.environment, var.name])
    propagate_at_launch = true
  }

  tag { 
    key                 = "ProvisionedBy"
    value               = var.provisioned
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "asg-policy-up" {
  name                      = join("-", [var.environment, var.name, "policy-up"])
  adjustment_type           = "ChangeInCapacity"
  autoscaling_group_name    = aws_autoscaling_group.asg.name
  estimated_instance_warmup = 180
  policy_type               = "StepScaling"

  metric_aggregation_type = "Average"
  step_adjustment {
    scaling_adjustment          = 2
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 20
  }

  step_adjustment {
    scaling_adjustment          = 4
    metric_interval_lower_bound = 20
  }

}

resource "aws_cloudwatch_metric_alarm" "cwatch-metric-up" {
  alarm_name          = join("-", [var.environment, var.name, "alarm-to-up"])
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asg-policy-up.arn]
}

resource "aws_autoscaling_policy" "asg-policy-down" {
  name                   = join("-", [var.environment, var.name, "policy-down"])
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "StepScaling"

  metric_aggregation_type = "Average"
  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_upper_bound = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "cwatch-metric-down" {
  alarm_name          = join("-", [var.environment, var.name, "alarm-to-down"])
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "20"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "15"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asg-policy-down.arn]
}
