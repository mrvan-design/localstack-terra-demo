terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.66.0"
    }
  }
  required_version = ">= 1.0.0"
}


# Provider AWS trỏ đến LocalStack 
provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true # 👈 Dòng này là quan trọng nhất!
  endpoints {
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
  }
}

# 🪣 S3 Bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "my-localstack-demo-bucket"

  tags = {
    Name = "demo-bucket"
  }
}

# 🌐 VPC mô phỏng
resource "aws_vpc" "demo_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo-vpc"
  }
}

# 📦 Subnet
resource "aws_subnet" "demo_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "demo-subnet"
  }
}

# 💻 EC2 instance (mô phỏng)
resource "aws_instance" "demo_instance" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.demo_subnet.id

  tags = {
    Name = "demo-ec2"
  }
}
