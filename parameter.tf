locals {
  names = [
    for index in var.parameters:
      index.name
  ]
  types = [
    for index in var.parameters:
      index.type
  ]
  values = [
    for index in var.parameters:
      index.value
  ]

}

resource "aws_ssm_parameter" "params" {
    count = length(var.parameters)
    name = local.names[count.index]
    type = local.types[count.index]
    value = local.values[count.index]
}