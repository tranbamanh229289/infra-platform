variable "environment"{
  type = string
}

variable "region"{
  type = string
}

# VPC
variable "cidr"{
  type = string
}

variable "enable_nat_gateway"{
  type = bool
}

variable "availability_zones"{
  type = list(string)
}

variable "public_subnet_cidrs"{
  type = list(string)
}

variable "private_subnet_cidrs"{
  type = list(string)
}

# EC2
variable "instance_count"{
  type = number
}

variable "instance_type"{
  type = string
}

variable "user_data_script"{
  type = string
}

# RDS
variable "instance_class"{
  type = string
}

variable "password"{
  type = string
}

#S3
variable "bucket_name"{
  type = string
}