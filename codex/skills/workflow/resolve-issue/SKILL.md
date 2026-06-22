---
name: resolve-issue
description: Resolve an agent-ready issue end-to-end and deliver a PR.
---

1. Gather any relevant context. Stop if the issue is not agent-ready.
2. Create a branch if there is no existing relevant PR branch.
3. Spawn the implementer subagent, then just wait for it to finish.
4. Ensure a relevant PR exists, then post the reported decisions as a PR comment.
5. Spawn the reviewer subagents in parallel, then just wait for both to finish.
6. Post the reported reviews as a PR comment without merging or reranking them.
7. Stop if no findings remain or a stopping condition applies; otherwise loop to step 3.

Do not pass parent conversation history or parent instructions to subagents. For context that subagents can fetch or inspect themselves, pass references instead of copying it into the prompt.

The implementer subagent should gather any relevant context and create a goal; then implement, verify, commit, push, and report the result, including the decisions the issue left open.

The standards reviewer subagent should check whether the PR conforms to codebase standards and relevant best practices, and meets maintainability expectations.

The spec reviewer subagent should check whether the PR faithfully implements the requirements and intent, preserves scope, handles edge cases, and avoids regressions.

A convergence failure is when progress stalls: findings recur, counts do not fall, or fixes regress clean parts. This signals the issue itself needs revision, not more rounds.

Required intervention is when only a human can unblock progress, such as a deploy, dashboard config, or credential provisioning. Report exactly what the user must do to continue.
