output "efs_id" {
  description = "EFS file system ID - used to create the Kubernetes StorageClass"
  value = aws_efs_file_system.seyoawe.id
}
