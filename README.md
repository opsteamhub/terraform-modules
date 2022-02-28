#### Terraform Modules

##### Example deploy AutoScaling Group + Appliction LoadBalancer

###### Arquivo main.tf

```
module "sg" {
  source            = "github.com/opsteamhub/terraform-modules//security_group"
  name              = var.project_name
  environment       = var.environment
}

module "rule_http" {
  source            = "github.com/opsteamhub/terraform-modules//security_group_rules"
  security_group_id = module.sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow trafic port http"
}

module "rule_https" {
  source            = "github.com/opsteamhub/terraform-modules//security_group_rules"
  security_group_id = module.sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow trafic port https"
}

module "rule_egress" {
  source            = "github.com/opsteamhub/terraform-modules//security_group_rules"
  security_group_id = module.sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow trafic port https"
}

module "lb" {
  source            = "github.com/opsteamhub/terraform-modules//application_loadbalancer"
  name              = var.project_name
  lb_type           = "application"
  security_group    = module.sg.id
  subnets           = ["subnet-f0cf5294", "subnet-c361379a"]
  environment       = var.environment
  vpc_id            = var.vpc_id

}

module "lb_listener" {
  source            = "github.com/opsteamhub/terraform-modules//loadbalancer_listener"
  load_balancer_arn = module.lb.arn
  target_group_arn  = module.target_group.arn
  protocol          = "HTTP"
  port              = "80"
}

module "target_group" {
  source            = "github.com/opsteamhub/terraform-modules//target_group"
  name              = var.project_name
  environment       = var.environment
  vpc_id            = var.vpc_id
  protocol          = "HTTP"
  port              = "80"
}

module "autoscaling" {
  source            = "github.com/opsteamhub/terraform-modules//auto_scaling_group"
  name              = var.project_name
  instance_type     = var.instance_type
  image_id          = var.image_id
  subnets           = var.subnets
  environment       = var.environment
  security_group    = module.sg.id
  key_name          = var.key_name
  target_group_arns = [module.target_group.arn]
}

module "codedeploy_app" {
  source      = "github.com/opsteamhub/terraform-modules//codedeploy_application"
  name        = var.project_name
  environment = var.environment
}

module "deployment_group_cmportal" {
  source                = "github.com/opsteamhub/terraform-modules//codedeploy_deployment_group"
  name                  = var.project_name
  app_name              = module.codedeploy_app.app_name
  service_role_arn      = aws_iam_role.ec2_role.arn
  deployment_group_name = var.group_name_cmportal
  environment           = var.environment
}

module "deployment_group_webmanager" {
  source                = "github.com/opsteamhub/terraform-modules//codedeploy_deployment_group"
  name                  = var.project_name
  app_name              = module.codedeploy_app.app_name
  service_role_arn      = aws_iam_role.ec2_role.arn
  deployment_group_name = var.group_name_webmanager
  environment           = var.environment
}
```

###### Arquivo variables.tf

```
variable "project_name" {}
variable "vpc_id" {}
variable "subnets" {
  default = []
}
variable "environment" {}
variable "key_name" {
  default = ""
}
variable "instance_type" {}
variable "image_id" {}  
```

###### Arquivo .tfvars

```
project_name        = "project_name"
vpc_id              = "vpc-xxxxxx"
subnets             = ["subnet-xxxxxx", "subnet-xxxxx"]
environment         = "environment"
key_name            = "key_name"
instance_type       = "t3.micro"
image_id            = "ami-xxxxxxxxxxxx
```