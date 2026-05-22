---
name: create-issue
description: Create one or more GitHub issues from provided context. Use when Codex must inspect context, ask one question at a time until enough information is available, choose goal-sized issue boundaries, and create actionable issues suitable for long uninterrupted agent work.
---

# Create Issue

## Outcome

Create one or more GitHub issues that give a future agent enough context to set a goal and work to completion without repeated clarification. Each issue should describe a coherent outcome, not a tiny task split by habit.

If essential information is missing, ask the user exactly one question and wait. Continue one question at a time until the issue can be created accurately.

## Workflow

1. Gather the available context from the user request, repository files, existing issues or PRs, logs, screenshots, and any referenced artifacts. Identify the desired outcome, affected surface area, known constraints, and uncertainty.

2. Before choosing issue boundaries, ask one focused question at a time for missing context that could materially change the outcome, scope, acceptance criteria, constraints, dependencies, priority, verification, or implementation safety. Continue until a future agent can work without repeated clarification.

3. Decide whether the work belongs in one issue or several. Prefer one larger issue when the work has one coherent outcome and can be reviewed as a single goal. Split only when the outcomes are independently valuable, can be completed in parallel, carry materially different risks, or need separate ownership.

4. Draft the issue body to fit the work. Include the problem context, desired outcome, acceptance criteria, relevant constraints, suggested verification, useful references, dependencies, and known handoff work when those details are available.

5. Create the GitHub issue or issues. Verify that each issue exists, has the intended title and body, and is linked to any relevant source issue, PR, milestone, label, or project when the context makes that relationship clear.

## Issue Scope

Size issues for goal execution. A good issue can sustain 24+ hours of continuous agent work when it has a clear outcome, stable constraints, and verifiable completion criteria.

Avoid splitting by file, layer, or short-session estimates alone. Split when the resulting issues can be solved and reviewed independently without forcing future agents to coordinate hidden shared state.

Make acceptance criteria observable. Prefer criteria that can be proven by tests, commands, UI behavior, logs, generated artifacts, or a reviewer-visible state change.
