
# -----------------------------
#          Modules 
# -----------------------------

module "vpc" {
source = "./modules/vpc"
cidr_block = "10.0.0.0/16"
project = var.project_name
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  depends_on = [module.vpc]
}

module "cloudfront" {
  source = "./modules/cloudfront"

  project              = var.project_name
  bucket_name          = module.s3.bucket_name
  bucket_arn           = module.s3.bucket_arn
  bucket_domain_name   = module.s3.bucket_regional_domain_name
  depends_on = [module.s3]
}


