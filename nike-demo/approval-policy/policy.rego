package env0

# Nike platform guardrail:
# A deployment whose estimated monthly cost increase is above the threshold
# pauses and waits for a platform admin to approve. Cheaper deployments (and
# operations with no cost impact, e.g. destroy) go through with no gate.
#
# Returning `pending` (not `deny`) makes env0 stop the deployment at
# WAITING_FOR_USER until an approver signs off, rather than hard-failing it.
# We always emit an explicit result so a custom policy never defaults to pending.

# USD / month. Above this, a deploy needs platform admin approval.
maxCostIncrease := 200.0

monthlyDiff := input.costEstimation.monthlyCostDiff

# Costly drop -> pause for platform admin approval.
pending[msg] {
	is_number(monthlyDiff)
	monthlyDiff > maxCostIncrease
	msg := sprintf(
		"Estimated monthly cost increase of $%.2f exceeds the $%.2f budget - Nike platform admin approval required before this drop goes live.",
		[monthlyDiff, maxCostIncrease],
	)
}

# Cheap drop -> goes live with no gate.
allow[msg] {
	is_number(monthlyDiff)
	monthlyDiff <= maxCostIncrease
	msg := sprintf("Estimated monthly cost increase of $%.2f is within the $%.2f budget.", [monthlyDiff, maxCostIncrease])
}

# No cost estimate to evaluate (e.g. a destroy) -> nothing to gate on cost.
allow[msg] {
	not is_number(monthlyDiff)
	msg := "No cost increase to evaluate."
}
