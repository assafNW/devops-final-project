# AWS Load Balancer Controller addon
resource "aws_eks_addon" "lbc" {
  cluster_name             = var.cluster_name
  addon_name               = var.lbc_addon_name
  service_account_role_arn = aws_iam_role.lbc.arn

  depends_on = [aws_iam_role_policy_attachment.lbc]
}