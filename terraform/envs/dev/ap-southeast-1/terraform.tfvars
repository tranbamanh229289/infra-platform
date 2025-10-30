environment = "dev"
region = "ap_southeast-1"

# VPC
cidr = "10.0.0.0/16"
enable_nat_gateway = false
availability_zones = [""]
public_subnet_cidrs = [""]
private_subnet_cidrs = [""]

# EC2
instance_count = 1
instance_type = "t3.micro"
user_data_script = <<-EOT
  #!/bin/bash
  apt-get update -y
  apt-get install -y nginx
  systemctl enable nginx
  systemctl start nginx
  EOT

# RDS
instance_class = ""
password = ""

#S3
bucket_name = ""