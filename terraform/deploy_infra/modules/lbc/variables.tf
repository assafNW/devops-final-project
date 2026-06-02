
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "eks_node_sg_id" {
  description = "Security group ID of the EKS node group — allows NFS ingress"
  type = string
}

variable "cluster_name" {
  type = string
}

variable "lbc_addon_name" {
  type = string
  default = "aws-load-balancer-controller"
}

variable "efs_csi_version" {
  type = string
  default = "v1.7.6-eksbuild.1"
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL of the EKS cluster"
  type        = string
}