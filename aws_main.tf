#terraform-aws >>##
# main.tf

terraform {
      required_providers {
          aws = {

           source = "hashicorp/aws"
           version = "~> 4.16"
}
}
required_version = ">= 1.2.0"

}

provider "aws" {

         region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
       count = 1                  #for more instances
       ami = "ami-08c40ec9ead489470"
       instance_type = "t2.micro"
        tags = {
                Name =  "TerraformBatch-Instance"

}
}

output "ec2_public_ips" {

    value = aws_instance.my_ec2_instance[*].public_ip

}

##terraform- variables >>>##
## main.tf

resource "local_file" "devops" {
          filename = "/home/ubuntu/terraform-course/terraform-variables/devops_test.txt"
          content = var.content_map["content1"]
}

resource "local_file" "devops-var" {
          filename = var.filename
          content = var.content_map["content2"]

}

output "devops_op_trainer" {

value = var.devops_op_learner

}


** variables.tf

resource "local_file" "devops" {
          filename = "/home/ubuntu/terraform-course/terraform-variables/devops_test.txt"
          content = var.content_map["content1"]
}

resource "local_file" "devops-var" {
          filename = var.filename
          content = var.content_map["content2"]

}

output "devops_op_trainer" {

value = var.devops_op_learner

}
ubuntu@ip-172-31-82-154:~/terraform-course/terraform-variables$ cat variables.tf
variable "filename" {
          default = "/home/ubuntu/terraform-course/terraform-variables/devops-automated.txt"
}

variable "content" {
          default = "This is auto generated file from a variable"
}

variable "devops_op_learner" {}

variable "content_map" {
type = map
default = {
"content1" = "this is a cool content 1"
"content2" = "this is a cooler content2"

}
}


###terraform-MetaArgument###

**main.tf**

terraform {
      required_providers {
          aws = {

           source = "hashicorp/aws"
           version = "~> 4.16"
}
}
required_version = ">= 1.2.0"

}

provider "aws" {

         region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
       count = 4
       ami = "ami-08c40ec9ead489470"
       instance_type = "t2.micro"
        tags = {
                Name =  "TerraformTestServer- ${count.index}"

}
}

***To change names of instances***

terraform {
      required_providers {
          aws = {

           source = "hashicorp/aws"
           version = "~> 4.16"
}
}
required_version = ">= 1.2.0"

}

provider "aws" {

         region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
       count = 4
       ami = "ami-08c40ec9ead489470"
       instance_type = "t2.micro"
        tags = {
                Name =  "TerraformServer- ${count.index}-test"

}
}


***terraform code for naming each instrance****
**,main.tf**

terraform {
      required_providers {
          aws = {

           source = "hashicorp/aws"
           version = "~> 4.16"
}
}
required_version = ">= 1.2.0"

}

provider "aws" {

         region = "us-east-1"
}

locals {
        instance_names = toset(["ProdTest", "DevTest", "ProdLike", "Production"])
}

resource "aws_instance" "my_ec2_instance" {
       for_each = local.instance_names
       ami = "ami-08c40ec9ead489470"
       instance_type = "t2.micro"
        tags = {
                Name =  each.key

}
} 

*** By Differenet AMI's INC* & convert in map***


terraform {
      required_providers {
          aws = {

           source = "hashicorp/aws"
           version = "~> 4.16"
}
}
required_version = ">= 1.2.0"

}

provider "aws" {

         region = "us-east-1"
}

locals {
        instance_names = {"ProdTest":"ami-0b0dcb5067f052a63","DevTest":"ami-08c40ec9ead489470","ProdLike":"ami-08c40ec9ead489470","Production":"ami-0b0dcb5067f052a63"}

}

resource "aws_instance" "my_ec2_instance" {
       for_each = local.instance_names
       ami = each.key
       instance_type = "t2.micro"
        tags = {
                Name =  each.value

}
}


*** To create  different instance type use: ***

locals {
        instance_names = {"ProdTest":"t2.micro","DevTest":"t2.large","ProdLike":"t4.small","Production":"t3.micro"}

}