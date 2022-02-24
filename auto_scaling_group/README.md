#### Terraform Module AutoScaling Group

```
module "autoscaling" {
    source = "./module"
    
    name          = ""
    instance_type = ""
    image_id      = ""
    subnets       = []
    environment   = ""
    security_group = ""
    key_name      = ""
  
}
```