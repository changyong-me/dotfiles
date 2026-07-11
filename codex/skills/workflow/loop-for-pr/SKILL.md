---
name: loop-for-pr
description: Autonomously implement an issue and deliver a reviewed PR.
---

# Loop for PR

Deliver a PR that satisfies the spec and has no unresolved actionable review findings. Keep the PR description and comments sufficient to understand the implementation, material decisions, validation, and remaining blockers. Continue fix rounds only while they make meaningful progress and no stop signal applies.

## The workflow

### 1. Gather the input, pick the branch

- The input is a spec — an `agent-ready` issue, one an agent can complete and verify with no human judgment in the middle. If none can be identified, ask for one before modifying the repository.
- Work on the branch associated with an existing PR for this spec; otherwise, create a fresh branch.

### 2. Implement the spec

- Spawn a fresh implementation subagent each round to preserve independence between attempts. On fix rounds, give it the findings to address and the decisions posted on the PR so far.
- The implementer reports material decisions that resolve an ambiguity, select among meaningful tradeoffs, or alter scope, including the rationale.
- Open a draft PR if none exists, and post those decisions as a comment on the PR.

### 3. Review the PR

- Run the `review` skill on the PR and provide the spec issue as the review spec; the Spec lens always runs here.
- Validate each finding against the spec, code, and available test evidence before choosing a fix. Mark a finding as a false positive only when concrete evidence disproves its premise or failure path; keep every finding not disproven actionable.
- Post one conversation comment per review round, with separate sections for all completed lenses and the disposition and rationale for each finding. Preserve false positives in the record instead of silently removing them.

### 4. Fix or finish

- Any stop signal below stops the loop: the PR stays a draft, and the report gives the user the PR, the remaining findings, and why it stopped.
- Actionable findings left mean a fix round — back to implement the spec (step 2) with them. Finish when the spec is satisfied and no actionable findings remain, then mark the PR ready for review.
- If the user provides a decision after either exit, post it as a PR comment before resuming the loop.

## Stop signals

- **The loop is not converging:** the same root-cause finding survives a fix intended to address it, fixes repeatedly reintroduce resolved findings, or two consecutive rounds show no meaningful reduction in finding severity or scope. Compare the findings themselves, not their count alone.
- **A finding points at a defect in the spec itself:** two requirements cannot both hold, or the implementation and finding rely on different defensible readings. Stop and request an explicit spec decision instead of starting another fix round.
- **Blocked on an action only a human can take:** providing required credentials, completing a deployment, or operating an external system unavailable to the agent. The report says exactly what the user must do to unblock.
