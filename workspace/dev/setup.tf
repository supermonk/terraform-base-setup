provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

terraform {
  required_version = ">= 0.11.11"
  backend "s3" {
    bucket         = "terraform-state-bucket-tt"
    key            = "tt/terraform/state/brain/terraform-base-tt.tfstate"
    region         = "us-west-1"
    profile        = "tp"
  }
}
module "TF_Module_S3_VPC_Bucket" {
  source = "../../terraform-code/terraform-aws-s3-buckets/"
  name  = "${var.terraform_vpc_bucket_name}-${var.env}"
  region = "${var.aws_region}"
}
module "TF_Module_S3_ARTIFACT_Bucket" {
  source = "../../terraform-code/terraform-aws-s3-buckets/"
  name  = "${var.terraform_artifact_log_bucket_name}-${var.env}"
  region = "${var.aws_region}"
}

module "TF_Module_ANALYTICS_KEYPAIR" {
  source = "../../terraform-code/terraform-aws-keypair/"
  location = "./"
  project = "${var.project}"
  env = "${var.env}"
  name = "${var.analytics_key_pair_name}"
}
module "TF_Module_EC2_KEYPAIR" {
  source = "../../terraform-code/terraform-aws-keypair/"
  location = "./"
  project = "${var.project}"
  env = "${var.env}"
  name = "${var.ec2_key_pair_name}"
}
module "TF_Module_DB_KEYPAIR" {
  source = "../../terraform-code/terraform-aws-keypair/"
  location = "./"
  project = "${var.project}"
  env = "${var.env}"
  name = "${var.db_key_pair_name}"
}

output "vpc_s3_log" {
  value = "${module.TF_Module_S3_VPC_Bucket.s3arn}"
}

output "key_pair_db_name" {
  value = "${module.TF_Module_DB_KEYPAIR.key_pair_name}"
}

output "key_pair_ec2_name" {
  value = "${module.TF_Module_EC2_KEYPAIR.key_pair_name}"
}

output "key_pair_analytics_name" {
  value = "${module.TF_Module_ANALYTICS_KEYPAIR.key_pair_name}"
}