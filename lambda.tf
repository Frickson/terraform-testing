module "lambda" {
  source  = "cloudposse/lambda-function/aws"
  version = "v0.5.0"

  filename      = "lambda.zip"
  function_name = "my-function-terraform"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
}

output "function_name"{
    value = module.lambda.function_name
}

resource "aws_lambda_function_url" "function_url" {
  function_name      = module.lambda.function_name
  authorization_type = "NONE"
}

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