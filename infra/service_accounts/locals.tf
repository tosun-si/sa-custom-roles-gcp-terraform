locals {
  service_accounts   = jsondecode(file("${path.module}/resource/service_accounts.json"))["serviceAccounts"]
  sa_roles_flattened = flatten([
  for sa in local.service_accounts : [
  for role in sa["roles"] : {
    account_id   = sa["account_id"]
    display_name = sa["display_name"]
    owner_role   = sa["owner_role"]
    owner_email  = sa["owner_email"]
    role         = role
  }
  ]
  ])
}