resource "aws_codedeploy_app" "codedeploy" {
  name = join("-", ["app", var.environment, var.name])
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_stack" {
  app_name              = aws_codedeploy_app.codedeploy.name
  deployment_group_name = join("-", ["group", var.environment, var.name])
  service_role_arn      = var.service_role_arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = join("-", ["group", var.environment, var.name])
    }
  }
}