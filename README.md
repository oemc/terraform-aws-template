# terraform-aws-template
Definition of an aws infrastructure deployed using terraform

# Usage
You need to configure your aws-cli with a IAM user with creation privileges for the resources listed in `main.tf`
``` 
terraform init
terraform apply
```
When you are done using the aws resources, you can remove them by running:
```
terraform destroy
```