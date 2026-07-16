---
name: loop-for-pr
description: Autonomously implement an issue and deliver a reviewed PR.
---

# Loop for PR

## The workflow

### 1. Gather the spec and pick the branch

- The input is a spec provided as an issue labeled `agent-ready`. An agent must be able to complete and verify it without human judgment or action. If none can be identified, ask for one before modifying the repository.
- Work on the branch associated with an existing PR for this spec; otherwise, create a fresh branch.

### 2. Implement and record decisions

- Spawn a fresh subagent to implement the spec on the branch and commit its work. On fix rounds, give it the findings to address and the current implementation decisions.
- The subagent reports only non-obvious decisions that materially affect the current design, including the rationale. Omit requirements, change summaries, and routine implementation details.
- Open a draft PR if none exists. Keep those decisions in the PR description, replacing any decisions that later fixes supersede.

### 3. Review the PR

- Run the `review` skill on the PR and provide the spec issue as the review spec; the Spec lens always runs here.
- Validate each finding against the spec, code, and available test evidence before choosing a fix. Mark a finding as a false positive only when concrete evidence disproves its premise or failure path; keep every finding not disproven actionable.
- Post one conversation comment per review round, with separate sections for all completed lenses and the disposition and rationale for each finding. Preserve false positives in the record instead of silently removing them.

### 4. Finish or loop back

- Any stop signal below stops the loop and leaves the PR as a draft. The report gives the user the PR, the remaining findings, and why it stopped.
- When actionable findings remain, start a fix round: return to step 2 and address them while implementing the spec. Finish when the spec is satisfied and no actionable findings remain, then mark the PR ready for review.
- If the user provides a decision after either exit, post it as a PR comment before resuming the loop.

## Stop signals

- **Non-converging loop:** the same root-cause finding survives a fix intended to address it, fixes repeatedly reintroduce resolved findings, or two consecutive rounds show no meaningful reduction in finding severity or scope. Compare the findings themselves, not their count alone.
- **Spec defect:** two requirements cannot both hold, or the implementation and finding rely on different defensible readings. Stop and request an explicit spec decision instead of starting another fix round.
- **Human-only blocker:** providing required credentials, completing a deployment, or operating an external system unavailable to the agent. The report says exactly what the user must do to unblock.
