terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "ec2demo" {
  ami           = "ami-0ba259e664698cbfc"
  instance_type = "t2.micro"

  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y nodejs
    git clone https://github.com/anuragabcr/PearlThoughts
    cd PearlThoughts
    npm install
    node index.js
  EOT
}

output "public_IP" {
  description = "EC2 Instance public IP"
  value = aws_instance.ec2demo.public_ip
}