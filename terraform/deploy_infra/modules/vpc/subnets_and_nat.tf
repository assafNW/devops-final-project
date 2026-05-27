# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  # For EKS load balancer
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-${count.index + 1}"
    # For EKS
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project_name}-${var.environment}-private-${count.index + 1}"
    # For EKS
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# NAT Gateway - one per Availability Zone for High Availability
resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "main" {
  count = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-${count.index + 1}"
  }
}