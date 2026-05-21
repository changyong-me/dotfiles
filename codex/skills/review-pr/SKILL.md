---
name: review-pr
description: Review pull requests for merge readiness. Use when the user asks Codex to review a PR, inspect a pull request, decide whether a PR is LGTM, find blocking issues before merge, or merge a PR after review approval.
---

# Review PR

## Overview

Review the pull request as a merge-readiness decision, not as a general code critique. Treat `LGTM` as an explicit statement that the PR can be merged immediately after the user confirms the PR comment and merge action.

## Workflow

### 1. Establish PR Context

Read the PR description, linked issue or requirement, changed files, relevant surrounding code, and current CI/check status when available.

Do not rely only on the diff when the intent depends on issue context, existing behavior, or repository conventions. Inspect enough code to judge the change against the real system.

### 2. Run Parallel Review Tracks

Use subagents for the independent review tracks when subagents are available. Spawn them with the same model and reasoning effort as yourself.

Assign each subagent one narrow responsibility:

- **Requirement fit**: decide whether the PR implements the requested behavior completely and accurately.
- **Behavior risk**: find bugs, regressions, runtime failures, edge cases, security issues, data risks, concurrency hazards, performance regressions, and operational risks.
- **Code quality**: review reuse of existing code, consistency with repository patterns, unnecessary complexity, maintainability, efficiency, naming, and test quality.

Tell each subagent to return only findings that matter for merge readiness. If a subagent notices an issue-level concern while doing its assigned track, it should flag that concern briefly.

While subagents work, handle coordination work that should stay with the main agent: collect PR metadata, check CI and mergeability, read linked issue context, identify repository conventions, and prepare to reconcile findings. Do not duplicate a subagent's assigned review track unless needed to integrate its result.

### 3. Check Whether the Issue Is the Real Problem

After the three review tracks complete, decide whether the implementation looks strange because the issue itself is wrong, underspecified, contradictory, or mis-scoped.

Run this issue-level review yourself when any of these signals appear:

- The implementation satisfies the written issue but still produces bad product or system behavior.
- Multiple review tracks point to awkward code caused by the requested behavior.
- The PR scope is much larger, smaller, or different than the linked issue implies.
- Acceptance criteria are missing, ambiguous, or inconsistent with existing behavior.
- The code appears forced to preserve a flawed requirement.

When the issue is the problem, say so directly. Do not frame it as a normal implementation defect unless the code also needs to change.

### 4. Decide Merge Readiness

Lead with findings, ordered by severity. Use file and line references for concrete code findings whenever possible.

Prefer findings that matter to merge readiness; do not block on style preferences, speculative rewrites, or broad refactors unless they create real risk.

Give a clear final verdict. The verdict must make merge readiness unambiguous:

- Use `LGTM` only when the PR can be merged immediately.
- Request changes when merge is blocked by a concrete issue.
- Ask for clarification when merge readiness depends on unresolved intent, product behavior, issue scope, or external constraints.
- State that the PR could not be fully reviewed when required context, tools, checks, or repository state were unavailable.

Never use `LGTM` when there is an unresolved blocker, unverified critical behavior, failing required check, conflict, or unclear requirement that could change the implementation.

### 5. Comment and Merge

After completing the review, ask the user whether to post the review result as a PR comment.

When the final verdict is `LGTM`, ask whether to post the `LGTM` review comment and whether to merge the PR after commenting.

When the final verdict is not `LGTM`, ask whether to post the findings as a PR comment. Do not offer to merge.

If the user approves merging after an `LGTM` verdict, verify the merge prerequisites that are visible from the available tools:

- Required checks have passed.
- Required reviews are satisfied.
- The PR has no merge conflicts.
- The target branch and merge method are clear.

Then merge the PR using the repository's normal merge method or the platform default when no repository convention is visible. Report the PR number, merge method, and resulting commit or merge status.
