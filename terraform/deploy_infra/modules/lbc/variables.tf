
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider arn of the EKS cluster"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider url of the EKS cluster"
  type        = string
}