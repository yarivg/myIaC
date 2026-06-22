package env0

# Nike platform guardrail:
# A deployment whose estimated monthly cost increase is above the threshold
# may not go live on its own - it pauses and waits for a platform admin to approve.
#
# Returning `pending` (not `deny`) makes env0 stop the deployment at
# WAITING_FOR_USER until an approver signs off, rather than hard-failing it.

# USD / month. Above this, a deploy needs platform admin approval.
maxCostIncrease := 200.0

monthlyDiff := input.costEstimation.monthlyCostDiff

pending[msg] {
	is_number(monthlyDiff)
	monthlyDiff > maxCostIncrease
	msg := sprintf(
		"Estimated monthly cost increase of $%.2f exceeds the $%.2f budget - Nike platform admin approval required before this drop goes live.",
		[monthlyDiff, maxCostIncrease],
	)
}
