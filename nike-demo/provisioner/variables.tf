variable "templates_repository" {
  type        = string
  description = "Git repository hosting the golden SNKRS Drop template IaC"
}

variable "templates_github_installation_id" {
  type        = number
  description = "env0 GitHub app installation id used to read the templates repository"
}

variable "drop_template_path" {
  type        = string
  description = "Path within the repository to the SNKRS Drop stack"
  default     = "nike-demo/snkrs-drop"
}

variable "approval_policy_path" {
  type        = string
  description = "Path within the repository to the OPA approval policy folder (metadata.yml + policy.rego)"
  default     = "nike-demo/approval-policy"
}

variable "developer_user_id" {
  type        = string
  description = "env0 user_id of the SNKRS developer (granted Deployer on the project)"
}

variable "platform_admin_user_id" {
  type        = string
  description = "env0 user_id of the Nike platform admin (granted Admin on the project)"
}
