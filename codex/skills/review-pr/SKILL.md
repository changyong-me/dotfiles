---
name: review-pr
description: Review a GitHub pull request by inspecting the PR, linked issues, discussion, and success intent, spawning parallel subagents for standards and spec review, then presenting their findings side by side with severity, file references, and open questions.
---

# Review PR

## Overview

Review a GitHub PR from two complementary angles: whether the code follows the project's standards and whether it faithfully implements the linked issue or stated spec. Inspect the PR and issues first, then delegate independent reviews and present the results clearly.

## Workflow

1. Inspect the PR before reviewing code. Read the title, description, commits, changed files, CI status, discussion, linked issues, and closing keywords; identify the base branch and capture the exact issue or spec material that defines success.

2. Spawn two subagents in parallel and wait for both subagents to finish. Assign one to standards review and one to spec review; give each the PR reference and linked issue or spec material, and require it to inspect relevant guidance and code independently.

3. Present both reviews to the user after both subagents finish. Keep the standards review and spec review separate; within each review, preserve the subagent's findings as reported, including severity, file or line references, open questions, and residual risks.

## Review Perspectives

Standards review asks whether the PR belongs in this codebase: local style, architecture, tests, security posture, performance expectations, dependency choices, and maintainability. It should judge the diff against documented guidance and nearby precedent rather than personal taste.

Spec review asks whether the PR solves the promised problem: linked issue intent, user-visible behavior, edge cases, failure modes, migrations, and validation. It should flag both missing behavior and extra behavior that changes scope without clear justification.
