variable "external_port" {
type = number
default = "1680"
}

variable "internal_port" {
type = number
default = "1600"
validation {
  condition = var.internal_port == 1600
  error_message = "The internal port must be 1600."
  }
}

variable "count_docker" {
type = number
default = "2"
}

