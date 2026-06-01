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

# EFS CSI Driver - EKS addon
resource "aws_eks_addon" "efs_csi" {
  cluster_name = var.cluster_name
  addon_name = var.efs_csi_addon_name
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [ aws_efs_mount_target.seyoawe ]
}
