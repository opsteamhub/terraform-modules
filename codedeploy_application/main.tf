resource "aws_codedeploy_app" "codedeploy" {
  name = join("-", ["app", var.environment, var.name])
}

