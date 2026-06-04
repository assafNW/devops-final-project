# General

variable "region" {
  description = "AWS cluster's region"
  type = string
  default = "us-east-2"
}

variable "project_name" {
  description = "Project name used as prefix for all resources"
  type        = string
  default     = "seyoawe"
}

variable "environment" {
  description = "Deployment Environment - dev/staging/prod"
  type = string
  default = "prod"
}

# VPC

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets - for each AZ"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets - for each AZ"
  type = list(string)
  default = [ "10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "AZ to deploy into - required by EKS"
  type = list(string)
  default = [ "us-east-2a", "us-east-2b" ]
}

# EKS

variable "eks_cluster_version" {
  description = "K8s versions for EKS cluster"
  type = string
  default = "1.31"
}

variable "node_instance_type" {
    description = "EC2 instance type for EKS nodes"
    type = string
    default = "t3.small"  
}

variable "node_desired_count" {
  description = "Desired number of EKS nodes"
  type = number
  default = 3
}

variable "node_min_count" {
  description = "Min number of EKS nodes"
  type = number
  default = 3
}


variable "node_max_count" {
  description = "Max number of EKS nodes"
  type = number
  default = 4
}