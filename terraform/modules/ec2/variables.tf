variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)  
}

variable "instance_count" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
  default = null
}

variable "ami_filters" {
  type = list(object({
    name = string
    values = list(string)
  }))
  default = []
}

variable "user_data_script" {
  type = string
  default = ""
}