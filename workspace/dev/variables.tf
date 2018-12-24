variable "aws_region" {
  type = "string"
}
variable "aws_profile" {
  type = "string"
}
variable "project" {
  type = "string"
}
variable "env" {
  type = "string"
}
variable "aws_replica_region" {
  type = "string"
}
# s3 buckets
variable "terraform_vpc_bucket_name" {
  type = "string"
}
variable "terraform_artifact_log_bucket_name" {
  type = "string"
}
# key pairs
variable "db_key_pair_name" {
  type = "string"
}
variable "analytics_key_pair_name" {
  type = "string"
}
variable "ec2_key_pair_name" {
  type = "string"
}