variable "psql-cluster-flavor" {
  type    = string
  default = "STD3-4-20"
}

variable "compute_flavor" {
  type = string
  default = "STD2-2-4"
}

variable "key_pair_name" {
  type = string
  default = "devops-YSPxRzZn"
}

variable "availability_zone_name" {
  type = string
  default = "MS1"
}

variable "login" {
  type = string
  sensitive = true
}

variable "pass" {
  type = string
  sensitive = true
}

variable "pid" {
  type = string
  sensitive = true
}

variable datadog_api_key {
  type = string
  sensitive = true
}

variable datadog_app_key {
  type = string
  sensitive = true
}

variable "pg_port" {
  type        = string
  default     = "5432"
}

variable "pg_database" {
  type        = string
  sensitive   = true
}

variable "pg_username" {
  type        = string
  sensitive   = true
}

variable "pg_password" {
  type        = string
  sensitive   = true
}

variable redmine_port {
  type = string
  sensitive = true
}

variable cert_name {
  type = string
  sensitive = true
}