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


output "vpc_s3" {
  value = "${module.TF_Module_S3_VPC_Bucket.s3arn}"
}