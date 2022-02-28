resource "aws_codedeploy_deployment_group" "codedeploy_group_stack" {
  app_name              = var.app_name
  deployment_group_name = join("-", [var.deployment_group_name, var.environment, var.name])
  service_role_arn      = var.service_role_arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = join("-", [var.environment, var.ec2_tag_group])
    }
  }
}