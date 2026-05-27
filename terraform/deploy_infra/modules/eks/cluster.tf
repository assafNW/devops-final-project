# EKS Cluster
resource "aws_eks_cluster" "main" {
  name = "${var.project_name}-${var.environment}"
  role_arn = aws_iam_role.cluster.arn
  version = var.cluster_version

  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [aws_security_group.cluster.id]
    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.cluster_policy
   ]
  
  tags = {
    Name = "${var.project_name}-${var.environment}-eks"
   }
}

# EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-${var.environment}-nodes"
  node_role_arn = aws_iam_role.node_group.arn
  subnet_ids = var.private_subnet_ids
  instance_types = [var.node_instance_type]

  scaling_config {
    desired_size = var.node_desired_count
    min_size = var.node_min_count
    max_size = var.node_max_count
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy,
   ]
  
  tags = {
    Name = "${var.project_name}-${var.environment}-node-group"
  }
} 

# Data Source - get cluster auth token
data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}