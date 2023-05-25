resource "aws_ssm_parameter" "params" {
    foreach = var.parameters
    name  = each.value.name
    type  = each.value.type
    value = each.value.value
}