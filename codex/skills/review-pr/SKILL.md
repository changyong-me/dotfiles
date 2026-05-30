---
name: review-pr
description: Review a GitHub pull request by inspecting the PR and linked issues, gathering repository context and issue intent, spawning two parallel subagents for standards and spec review, then presenting their findings side by side with severity, file references, and open questions.
---

# Review PR

## Overview

Use this skill to review a GitHub PR from two complementary angles: whether the code follows the project's standards, and whether it faithfully implements the linked issue or stated spec. Inspect the PR and issues first, then delegate independent reviews and present the results clearly.

## Workflow

1. Inspect the PR before reviewing code. Read the title, description, commits, changed files, CI status, discussion, linked issues, and closing keywords; identify the base branch and capture the exact issue or spec material that defines success.

2. Gather context from repository guidance, docs, ADRs, lint or test configuration, existing patterns near the diff, and any review guidance already present. Note validation commands that have run and any missing checks that affect confidence.

3. Spawn two subagents in parallel and wait for both results. Assign one to standards review and one to spec review; give each the PR reference, linked issue context, relevant guidance, and permission to inspect the code independently.

4. Ask the standards subagent to find deviations from project conventions, maintainability risks, test gaps, unsafe tooling, and mismatches with established architecture. Ask the spec subagent to compare behavior against the issue, edge cases, and acceptance intent.

5. Present both reviews to the user after both subagents finish. Lead with actionable findings ordered by severity and grounded in file or line references, then include open questions, residual risks, and a brief note when either perspective found no issues.

## Review Perspectives

Standards review asks whether the PR belongs in this codebase: local style, architecture, tests, security posture, performance expectations, dependency choices, and maintainability. It should judge the diff against documented guidance and nearby precedent rather than personal taste.

Spec review asks whether the PR solves the promised problem: linked issue intent, user-visible behavior, edge cases, failure modes, migrations, and validation. It should flag both missing behavior and extra behavior that changes scope without clear justification.
