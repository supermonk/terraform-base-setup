#generate

resource "tls_private_key" "keypair" {
  algorithm   = "RSA"
  rsa_bits = "2048"
  ecdsa_curve = "P521"
}

locals {
  full_name = "${var.project}-${var.env}-${var.name}"
}

#write to output
resource "local_file" "public" {
  content     = "${tls_private_key.keypair.public_key_pem}"
  filename = "${var.location}/keypair/${local.full_name}/${local.full_name}_pub.pem"
  provisioner "local-exec" {
    # replace first and last line
    command = "sed -i .bak -e '$d' ${local_file.public.filename};sed -i .bak -e 1d ${local_file.public.filename} "
  }
}
resource "local_file" "private" {
  content     = "${tls_private_key.keypair.private_key_pem}"
  filename = "${var.location}/keypair/${local.full_name}/${local.full_name}_private.pem"
}

# upload to aws
resource "aws_key_pair" "keypair_upload" {
  depends_on = ["local_file.public","tls_private_key.keypair"]
  key_name   = "${local.full_name}"
  public_key = "${file("${local_file.public.filename}")}"
}

output "key_pair_id" {
  value = "${aws_key_pair.keypair_upload.id}"
}
output "key_pair_name" {
  value = "${aws_key_pair.keypair_upload.key_name}"
}
