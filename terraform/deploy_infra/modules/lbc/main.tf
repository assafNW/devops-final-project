# AWS Load Balancer Controller 
resource "helm_release" "lbc" {
  name = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart = "aws-load-balancer-controller"
  namespace = "kube-system"
  create_namespace = false

  set {
    name = "clusterName"
    value = var.cluster_name
  }
  set {
    name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.lbc.arn
  }
  set {
    name = "vpcId"
    value = var.vpc_id
  }

  depends_on = [aws_iam_role_policy_attachment.lbc]
}