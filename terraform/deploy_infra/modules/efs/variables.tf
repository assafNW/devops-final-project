
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

variable "efs_csi_version" {
  type = string
  default = "v1.7.6-eksbuild.1"
}

