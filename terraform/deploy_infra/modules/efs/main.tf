# Provisions EFS for shared ReadWriteMany storage between engine and CLI pods.
# Required for lifetimes-pvc, logs-pvc, workflows-pvc and modules-pvc in the Helm chart.

# EFS File System
resource "aws_efs_file_system" "seyoawe" {
  creation_token = "${var.project_name}-efs"
  encrypted = true

  tags = {
    Name = "${var.project_name}-efs"
    Project = var.project_name
  }
}

# Security Group for EFS mount targets
resource "aws_security_group" "efs" {
  name = "${var.project_name}-efs-sg"
  description = "Allow NFS traffic from EKS nodes to EFS"
  vpc_id = var.vpc_id

  ingress {
    description = "NFS from EKS nodes"
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    security_groups = [var.eks_node_sg_id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.project_name}-efs-sg"
    Project = var.project_name
  }
}

# EFS Mount targets - one per private subnet
resource "aws_efs_mount_target" "seyoawe" {
  count = length(var.private_subnet_ids)
  file_system_id = aws_efs_file_system.seyoawe.id
  subnet_id = var.private_subnet_ids[count.index]
  security_groups = [aws_security_group.efs.id]
}

# OIDC Provider for the EKS cluster (enables IRSA)
data "tls_certificate" "eks" {
  url = var.cluster_oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = var.cluster_oidc_issuer_url
}

# IAM Role for EFS CSI Driver (IRSA)
resource "aws_iam_role" "efs_csi" {
  name = "${var.project_name}-efs-csi-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:efs-csi-controller-sa"
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "efs_csi" {
  role       = aws_iam_role.efs_csi.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

# EFS CSI Driver - EKS addon
resource "aws_eks_addon" "efs_csi" {
  cluster_name = var.cluster_name
  addon_name = var.efs_csi_addon_name
  service_account_role_arn = aws_iam_role.efs_csi.arn 
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [ aws_efs_mount_target.seyoawe ]
}
