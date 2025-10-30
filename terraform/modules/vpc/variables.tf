variable "environments" {
  type = string
}

variable "cidr" {
  type = string
}

variable "enable_nat_gateway" {
  type = bool
}

variable "availability_zones" {
  type = list(string)
  default = []  
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = []
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = []
}