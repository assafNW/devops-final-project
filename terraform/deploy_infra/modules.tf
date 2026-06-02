# Deploy VPC module
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

# Deploy EKS module
module "eks" {
  source = "./modules/eks"
  
  project_name = var.project_name
  environment = var.environment
  cluster_version = var.eks_cluster_version
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  node_instance_type = var.node_instance_type
  node_desired_count = var.node_desired_count
  node_min_count = var.node_min_count
  node_max_count = var.node_max_count

  depends_on = [
    module.vpc
  ]
}

# Deploy EKS module
module "efs" {
  source = "./modules/efs"
  
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_node_sg_id = module.eks.node_sg_id
  cluster_name = module.eks.cluster_name
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  depends_on = [
    module.eks
  ]
}

# Deploy LBC module - Load Balancer
module "lbc" {
  source = "./modules/lbc"
  
  project_name = var.project_name
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_node_sg_id = module.eks.node_sg_id
  cluster_name = module.eks.cluster_name
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  
  depends_on = [
    module.eks
  ]
}