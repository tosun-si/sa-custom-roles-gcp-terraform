resource "google_project_iam_custom_role" "custom_roles" {
  for_each = local.custom_roles

  project     = var.project_id
  role_id     = each.value["roleId"]
  title       = each.value["title"]
  description = each.value["description"]
  permissions = each.value["permissions"]
}