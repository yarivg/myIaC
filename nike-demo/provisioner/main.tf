# =============================================================================
#  Nike platform-as-code
#  This single env0 environment ("env0 provisioner") configures the whole
#  Nike org using the env0 Terraform provider: the project, the golden
#  template, the approval guardrail, and who can do what.
# =============================================================================

# --- The project the SNKRS team self-serves in -------------------------------
resource "env0_project" "snkrs" {
  name        = "SNKRS Platform"
  description = "Nike SNKRS app - self-service infrastructure for sneaker drops"
}

# --- Project policy: cost estimation ON, no blanket approval gate ------------
# Approval is driven purely by the OPA cost policy below, so cheap drops deploy
# freely and only costly ones pause for a platform admin.
resource "env0_project_policy" "snkrs" {
  project_id                = env0_project.snkrs.id
  requires_approval_default = false
  include_cost_estimation   = true
  max_ttl                   = "4-d"
  default_ttl               = "4-d"
}

# --- Guardrail: OPA cost-approval policy (the env0 provider applying a policy) -
# When a deploy's estimated monthly cost increase exceeds the threshold in
# approval-policy/policy.rego, the deployment pauses (WAITING_FOR_USER) until a
# Nike platform admin approves it.
resource "env0_approval_policy" "cost_gate" {
  name                   = "SNKRS Cost Approval"
  repository             = var.templates_repository
  path                   = var.approval_policy_path
  github_installation_id = var.templates_github_installation_id
}

resource "env0_approval_policy_assignment" "cost_gate" {
  scope        = "PROJECT"
  scope_id     = env0_project.snkrs.id
  blueprint_id = env0_approval_policy.cost_gate.id
}

# --- Golden template the developers deploy from ------------------------------
resource "env0_template" "drop_stack" {
  name                   = "SNKRS Drop Stack"
  description            = "Golden template for a sneaker-drop environment (catalog, cache, queue, storefront workers)"
  repository             = var.templates_repository
  path                   = var.drop_template_path
  github_installation_id = var.templates_github_installation_id
  type                   = "terraform"
  terraform_version      = "1.5.7"
}

resource "env0_template_project_assignment" "drop_stack" {
  template_id = env0_template.drop_stack.id
  project_id  = env0_project.snkrs.id
}

# --- Who can do what ---------------------------------------------------------
# Platform admin: full control of the project (and the approver).
resource "env0_user_project_assignment" "platform_admin" {
  user_id    = var.platform_admin_user_id
  project_id = env0_project.snkrs.id
  role       = "Admin"
}

# SNKRS developer: can deploy, but cannot self-approve a gated deployment.
resource "env0_user_project_assignment" "developer" {
  user_id    = var.developer_user_id
  project_id = env0_project.snkrs.id
  role       = "Deployer"
}

output "project_id" {
  value = env0_project.snkrs.id
}

output "drop_template_id" {
  value = env0_template.drop_stack.id
}
