# Used by Ansible to connect to the cluster

output "vpc_id" {
  description = "VPC_ID"
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value = module.eks.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = module.vpc.public_subnet_ids
}

output "eks_cluster_name" {
  description = "EKS cluster name - used by Ansible to configure kubectl"
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS API server endpoint - used by Ansible to configure kubectl"
  value = module.eks.cluster_endpoint
}

output "eks_cluster_ca_certificate" {
  description = "EKS cluster CA certificate - used by Ansible to configure kubectl"
  value = module.eks.cluster_ca_certificate
  sensitive = true
}

output "node_group_role_arn" {
  description = "IAM role ARN for the EKS node group - used by Ansible to configure kubectl"
  value = module.eks.node_group_role_arn
}

output "efs_id" {
  value = module.efs.efs_id
}