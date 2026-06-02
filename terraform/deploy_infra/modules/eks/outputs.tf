output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_token" {
  value     = data.aws_eks_cluster_auth.main.token
  sensitive = true
}

output "node_group_role_arn" {
  value = aws_iam_role.node_group.arn
}

output "node_sg_id" {
  value = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}