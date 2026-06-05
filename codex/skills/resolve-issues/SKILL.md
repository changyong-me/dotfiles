---
name: resolve-issues
description: Resolve agent-ready issues and open or update a PR.
---

1. Inspect the issues. Stop if any issue is not agent-ready.
2. Create a branch if there is no existing relevant PR branch.
3. For each issue, spawn a subagent, just wait for it to finish, then move to the next issue.
4. After all subagents finish, open or update a PR that closes the issues when merged.

Do not pass parent conversation history or parent instructions to subagents. For context that subagents can fetch or inspect themselves, pass references instead of copying it into the prompt.

Subagents should inspect the issue, list available skills, read their descriptions, and use all applicable skills; then plan the fix, implement it, validate it, commit the changes, and report the result.
