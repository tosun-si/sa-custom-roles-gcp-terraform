locals {
  custom_roles = jsondecode(file("${path.module}/resource/custom_roles.json"))["customRoles"]
}