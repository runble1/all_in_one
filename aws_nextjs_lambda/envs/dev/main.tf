locals {
  service = "nextjs_cloudfront"
}

module "ecr" {
  source        = "../../modules/ecr"
  name          = local.service
  holding_count = 5
}

module "cloudwatch" {
  source  = "../../modules/cloudwatch"
  service = local.service
}

module "lambda" {
  source         = "../../modules/lambda"
  handler        = "index.handler"
  function_name  = "${var.env}-${local.service}"
  repository_url = module.ecr.repository_url
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = "${var.env}-${local.service}"
}

module "cloudfront" {
  source                      = "../../modules/cloudfront"
  function_url_domain         = replace(replace(module.lambda.function_url, "https://", ""), ".aws/", ".aws")
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  bucket_arn                  = module.s3.bucket_arn
  bucket_id                   = module.s3.bucket_id
}
