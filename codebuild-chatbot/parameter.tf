/* locals {
  params_names = [
    for index in var.parameters:
      index.name
  ]
  params_types = [
    for index in var.parameters:
      index.type
  ]
  params_values = [
    for index in var.parameters:
      index.value
  ]
} */

/* resource "aws_ssm_parameter" "params" {
    count = length(var.parameters)
    name = local.params_names[count.index]
    type = local.params_types[count.index]
    value = local.params_values[count.index]
} */

/* resource "aws_ssm_parameter" "params-2" {
  for_each = var.parameters-2
  name  = each.value.name
  type  = each.value.type
  value = each.value.value
} */

