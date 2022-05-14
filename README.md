# terraform-aws-template
Definition of an aws infrastructure deployed by using terraform

# Usage
You need to configure your aws-cli with a IAM user with creation privileges for the resources listed in main.tf
``` 
terraform init
terraform apply
```
When you are done, you can remove the created resources by running:
```
terraform destroy
```