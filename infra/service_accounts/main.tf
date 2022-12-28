resource "google_service_account" "sa_list" {
  project  = var.project_id
  for_each = local.service_accounts

  account_id   = each.value["account_id"]
  display_name = each.value["display_name"]
}

resource "google_project_iam_member" "sa_roles" {
  for_each   = {for idx, sa in local.sa_roles_flattened : "${sa["account_id"]}_${sa["role"]}" => sa}
  project    = var.project_id
  role       = replace(each.value["role"], "{{PROJECT_ID}}", var.project_id)
  member     = "serviceAccount:${each.value["account_id"]}@${var.project_id}.iam.gserviceaccount.com"
  depends_on = [google_service_account.sa_list]
}

resource "google_service_account_iam_member" "admin_account_iam" {
  for_each           = local.service_accounts
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value["account_id"]}@${var.project_id}.iam.gserviceaccount.com"
  role               = each.value["owner_role"]
  member             = each.value["owner_email"]
  depends_on         = [google_service_account.sa_list]
}