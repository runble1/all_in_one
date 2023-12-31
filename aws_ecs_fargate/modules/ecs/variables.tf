variable "service" {}

variable "vpc_id" {}
variable "alb_target_group_arn" {}
variable "alb_sg_id" {}
variable "app_port" {}
variable "image_url" {}
variable "image_tag" {}

data "aws_caller_identity" "self" {}