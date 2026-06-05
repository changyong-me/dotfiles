---
name: resolve-issues
description: Resolve agent-ready issues and open or update a PR.
---

1. Inspect the issues. Stop if any issue is not agent-ready.
2. Create a branch if there is no existing PR branch.
3. For each issue, spawn a subagent, wait for it to finish, then move to the next issue.
4. After all subagents finish, open or update a PR that closes the issues when merged.

Subagents should not receive parent conversation history. They should inspect the issue, state the available skills, read their descriptions, and use any relevant skills; then plan the fix, implement it, validate it, commit the changes, and report the result.
