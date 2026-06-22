package env0

# Nike platform guardrail (OPA / Rego):
# When a DEPLOY's declared monthly cost is over the budget, the deployment pauses
# and waits for a platform admin to approve (returns `pending` -> WAITING_FOR_USER,
# not `deny`). Cheaper deploys, and non-deploy operations (e.g. destroy), go through.
# An explicit allow is always emitted so a custom policy never defaults to pending.

# USD / month. Above this, a deploy needs platform admin approval.
maxCostIncrease := 5.0

# Cost is declared by the environment as a Terraform variable.
cost := to_number(object.get(input.variables.terraform, "monthly_cost_usd", "0"))

is_deploy {
	input.deploymentRequest.type == "deploy"
}

# Over-budget drop -> pause for platform admin approval.
pending[msg] {
	is_deploy
	cost > maxCostIncrease
	msg := sprintf("Estimated monthly cost of $%v exceeds the $%v budget - Nike platform admin approval required before this drop goes live.", [cost, maxCostIncrease])
}

# Within-budget drop -> goes live with no gate.
allow[msg] {
	is_deploy
	cost <= maxCostIncrease
	msg := sprintf("Estimated monthly cost of $%v is within the $%v budget.", [cost, maxCostIncrease])
}

# Anything that isn't a deploy (e.g. destroy) -> nothing to gate on cost.
allow[msg] {
	not is_deploy
	msg := "Non-deploy operation - no cost gate."
}
