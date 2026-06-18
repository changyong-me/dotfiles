---
name: implement
description: Resolve an issue or address a PR review comment, then review the PR.
---

1. Inspect any relevant issue, PR, and PR review comment. Stop if any issue is not agent-ready.
2. Create a branch if there is no existing relevant PR branch.
3. Spawn the implementation subagent, then just wait for it to finish.
4. Open a PR if needed, otherwise push to the existing PR branch.
5. Spawn the standards and spec review subagents in parallel, then just wait for both to finish.
6. Post both reviews as a PR comment without merging or reranking the findings.

Do not pass parent conversation history or parent instructions to subagents. For context that subagents can fetch or inspect themselves, pass references instead of copying it into the prompt.

The implementation subagent should inspect any relevant context, plan the work, and create a goal; then implement, validate, commit, and report the result.

The standards review subagent should check whether the PR conforms to codebase standards and relevant best practices, and meets maintainability expectations.

The spec review subagent should check whether the PR faithfully implements the requirements and intent, preserves scope, handles edge cases, and avoids regressions.
