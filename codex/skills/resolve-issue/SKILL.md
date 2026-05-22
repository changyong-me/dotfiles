---
name: resolve-issue
description: Resolve a GitHub issue into a merge-ready pull request. Use when Codex must set a goal, implement or address review feedback, run verification, push commits, open or update a PR, obtain independent subagent reviews, and finish only when the PR is merge-ready or has explicit human handoff items.
---

# Resolve Issue

## Outcome

The final artifact is a pushed, merge-ready PR, or a PR that becomes merge-ready after clearly stated human handoff work is completed. The PR must include a general comment that summarizes the outcome, verification, review results, and any remaining handoff items.

Completion requires passing relevant static checks, three independent subagent reviews covering requirements fit, behavioral risk, and code quality, and main-agent triage that leaves no blocker except explicit human handoff work.

## Workflow

1. Set a goal to resolve the referenced issue into a pushed PR that clears the review gate and has no blocker except explicit human handoff work.

2. Read the issue, existing PR if present, relevant comments, repository conventions, and changed files. Derive the intended outcome, acceptance criteria, constraints, and likely verification commands.

3. Implement the issue or address review feedback with the narrowest changes that satisfy the outcome. Preserve unrelated work, match local style, and keep any assumptions visible in the PR when they affect reviewer judgment.

4. Run the repository's relevant static checks and tests. Fix failures caused by the work, rerun the checks that matter, and record any checks that cannot be executed with the reason.

5. Commit the verified changes and push the branch. Open a PR if none exists; otherwise update the existing PR. Ensure the PR body describes the outcome, verification, and any important implementation notes.

6. Spawn three independent review subagents after the PR is up to date. Ask one to review requirements fit against the issue, one to review behavioral and regression risk, and one to review code quality, maintainability, and test coverage.

7. Triage the subagent reviews yourself. Discard false positives and non-blocking preferences. For each real blocker within agent control, leave a general PR comment summarizing the review finding and intended remediation, make the fix, rerun verification, push the update, and repeat the three-review gate.

8. Complete the goal only after the review gate has no remaining blocker within agent control. If any residual work requires human action, list it clearly in the final PR comment with the current PR status and the exact action needed.

## Review Gate

A requirements blocker means the PR does not satisfy the issue, omits a stated acceptance criterion, changes the requested scope in a material way, or lacks evidence for a required behavior.

A behavioral blocker means the PR introduces a credible runtime regression, data-loss risk, security or privacy risk, migration issue, compatibility issue, or unhandled edge case that can be fixed in the repository.

A code-quality blocker means the PR is unnecessarily complex, inconsistent with local patterns, under-tested for the risk involved, brittle in a way likely to break normal use, or leaves artifacts from the implementation that should be cleaned up.

Treat missing credentials, external approvals, account permissions, production-only state, manual QA that cannot be automated locally, and unresolved product decisions as handoff work. Do not treat handoff work as a reason to skip the PR comment or the review gate; make the PR as ready as possible first.
