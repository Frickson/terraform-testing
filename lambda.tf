module "lambda" {
  source  = "cloudposse/lambda-function/aws"
  version = "v0.5.0"

  filename      = "lambda.zip"
  function_name = "my-function-terraform"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
}