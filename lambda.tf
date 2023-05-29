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

locals {
  /* updated_function_1 = merge(
    var.lambda["function-1"],
    {
      new_attribute = "value"
    }
  ) */
  new_value = [for x in var.lambda: merge(var.lambda[x],
    {
      new_attribute = "value"
    })]
}

output "updated_function_1" {
  value = local.new_value
}
/* output "function_name"{
    value = module.lambda.function_name
}

resource "aws_lambda_function_url" "function_url" {
  function_name      = module.lambda.function_name
  authorization_type = "NONE"
} */

/* resource "aws_lambda_function_url" "test_live" {
  function_name      = aws_lambda_function.test.function_name
  qualifier          = "my_alias"
  authorization_type = "AWS_IAM"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
} */