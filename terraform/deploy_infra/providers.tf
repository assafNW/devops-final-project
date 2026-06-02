terraform {
  # for dynamic taggings 
  required_version = ">= 1.6.0"

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project = var.project_name
      Environment = var.environment
      ManagedBy = "Terraform"
    }
  }
}

# Kubernetes provider — uses the EKS cluster output to authenticate
provider "kubernetes" {
  host = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  token = module.eks.cluster_token
}