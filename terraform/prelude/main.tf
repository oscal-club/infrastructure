module "remote_state_bucket" {
  source               = "../aws/s3"
  create_bucket        = var.create_bucket
  attach_public_policy = var.attach_public_policy
  bucket               = var.bucket
  acl                  = var.acl
  tags                 = var.tags
  force_destroy        = var.force_destroy
  versioning           = var.versioning
  server_side_encryption_configuration = try(lookup(var.server_side_encryption_configuration, "rule"), {
    "rule" : {
      "apply_server_side_encryption_by_default" : {
        "sse_algorithm" : "aws:kms"
        "kms_master_key_id" : data.aws_kms_alias.s3.arn
      }
    }
  })
}