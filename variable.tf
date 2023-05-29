variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0bef6cc322bfff646"
}

variable "instance" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0d6a79ed118f22f48"
}

resource "aws_s3_bucket" "jenkinsartifactsbucket" {
  bucket = "jenkinsartifactsbucket"

  tags = {
    Name = "jenkins-s3-bucket"
  }
}

variable "ec2_user_data" {
  description = "user data for jenkins ec2"
  type        = string
  default     = <<EOF
    #!/bin/bash
    sudo yum update –y
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum upgrade
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    EOF
}