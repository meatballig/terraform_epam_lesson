variable "external_port" {
type = number
default = "1880"
}

variable "internal_port" {
type = number
default = "1880"
validation {
  condition = var.internal_port == 1880
  error_message = "The internal port must be 1880."
  }
}

variable "count_docker" {
type = number
default = "1"
}

