module "lambda_function" {
  for_each = var.lambda
  source  = "github.com/nec-msbu-devops/aws-lambda-function"
  filename      = each.value.filename
  function_name = each.key
  handler       = each.value.handler
  runtime       = each.value.runtime
  enable_function_url = each.value.enable_function_url
  function_url_auth_type = each.value.function_url_auth_type
}

/* locals {
  new_value = [for x in var.lambda: merge(x,
    {
      new_attribute = "value"
    })]
 }

output "updated_function_1" {
  value = local.new_value
} */
