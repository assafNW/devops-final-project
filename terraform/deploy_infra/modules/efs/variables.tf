
variable "project_name" {
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

variable "efs_csi_addon_name" {
  type = string
  default = "aws-efs-csi-driver"
}

variable "oidc_provider_arn" {
  description = "OIDC provider arn of the EKS cluster"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider url of the EKS cluster"
  type        = string
}