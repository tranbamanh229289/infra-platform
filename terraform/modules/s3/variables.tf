variable "environment" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "enable_versioning" {
  type = bool
  default = true
}

variable "lifecycle_days" {
  type = number
  default = 30
}

variable "policy"{
  type = object({
    Version = string
     Statement = list(object({
       Effect = string
       Principal = string
       Action = list(string)
       Resource = string 
     }))
  })
}