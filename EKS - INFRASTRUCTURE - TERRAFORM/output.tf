output "cluster_id" {
  value = aws_eks_cluster.cicd-project.id
}

output "node_group_id" {
  value = aws_eks_node_group.cicd-project.id
}

output "vpc_id" {
  value = aws_vpc.cicd-project_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.cicd-project_subnet[*].id
}

