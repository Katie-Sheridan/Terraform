#Week20 Project LUIT
#Create Jenkins Server using TF

resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance
  user_data              = var.ec2_user_data
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = {
    Name = "WK20-TF"
  }
}


#create security group
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg" 
  vpc_id      = var.vpc_id
  description = "Allow SSH and HTTP traffic"
 
 ingress {
    description = "allow incoming SSH from IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "allow access to jenkins server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
 
  ingress {
    description = "allow access to jenkins server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_s3_bucket" "jenkins_artifacts05272023" {
  bucket = "jenkins-artifacts05272023"
}