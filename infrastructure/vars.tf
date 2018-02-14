
variable "name" { default = "" } #name of your service
variable "aws_region" { default = "" } #i.e ap-southeast-2
variable "site_url" {default = ""} # i.e maxrozen.com - NOTE - this assumes you already have your URL in Route 53!
variable "comment" { default = "" } #i.e maxrozen.com
variable "account_id" { default = "" } #see account id under https://console.aws.amazon.com/billing/home?#/account
variable "graphql_endpoint" { default = "graphql"} #so you'd hit /graphql to reach your endpoint
variable "graphql_endpoint_url" { default = "" } #usually you'd set this to maxrozen.com or api.maxrozen.com
variable "acm_certificate_arn" { default = ""} #create a cert here: https://console.aws.amazon.com/acm/home?region=us-east-1#/wizard/

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}
