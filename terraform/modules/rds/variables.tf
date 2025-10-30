variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_class" {
  type = string
}

variable "engine" {
  type = string
  default = "postgres"
}

variable "engine_version" {
  type = string
  default = "17.4"
}

variable "allocated_storage" {
  type = number
  default = 20
}

variable "db_name" {
  type = string
  default = "db"
}

variable "db_port" {
  type = number
  default = 5432
}

variable "cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "username" {
  type = string
  default = "admin"
}

variable "password" {
  type = string
  sensitive = true
}
