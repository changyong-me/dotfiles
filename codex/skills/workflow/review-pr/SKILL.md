---
name: review-pr
description: Review a PR from two independent perspectives.
---

1. Inspect the PR and its linked issues.
2. Spawn the standards and spec review subagents in parallel, then just wait for both to finish.
3. After both subagents finish, present their reviews without merging or reranking the findings.

Do not pass parent conversation history or parent instructions to subagents. For context that subagents can fetch or inspect themselves, pass references instead of copying it into the prompt.

The standards review subagent should check whether the PR conforms to codebase standards and relevant best practices, and meets maintainability expectations.

The spec review subagent should check whether the PR faithfully implements the requirements and intent, preserves scope, handles edge cases, and avoids regressions.
