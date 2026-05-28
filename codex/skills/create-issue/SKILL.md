---
name: create-issue
description: Create one or more GitHub issues from provided context. Use when Codex must inspect context, ask one question at a time until enough information is available, choose goal-sized issue boundaries, and create actionable issues suitable for long uninterrupted agent work.
---

# Create Issue

## Outcome

The final artifact is one or more GitHub issues that give a future agent enough context to set a goal and work to completion without repeated clarification. Each issue describes a coherent outcome, not a tiny task split by habit.

Completion requires enough context to choose issue boundaries, state observable acceptance criteria, include relevant constraints and verification guidance, and create the issue or issues in GitHub.

## Workflow

1. Gather the available context from the user request, repository files, existing issues or PRs, logs, screenshots, and any referenced artifacts. Identify the desired outcome, affected surface area, known constraints, and uncertainty.

2. Before choosing issue boundaries, identify whether missing context could materially change the outcome, scope, acceptance criteria, constraints, dependencies, priority, verification, or implementation safety. If so, ask one focused question at a time until the issue can be created as a clear, goal-ready unit of work.

3. Decide whether the work belongs in one issue or several. Prefer one larger issue when the work has one coherent outcome and can be reviewed as a single goal. Split only when each resulting issue has independent completion meaning, observable acceptance criteria, and can be reviewed and merged without relying on hidden shared state.

4. Draft the issue body to fit the work. Include the problem context, desired outcome, acceptance criteria, relevant constraints, suggested verification, useful references, dependencies, and known handoff work when those details are available.

5. Create the GitHub issue or issues. Verify that each issue exists, has the intended title and body, and is linked to any relevant source issue, PR, milestone, label, or project when the context makes that relationship clear.

## Issue Scope

Size issues around independently useful capabilities or observable outcomes, not implementation slices. A good issue describes what becomes possible or guaranteed through a public interface or stable contract.

The capability does not have to be end-user facing. It may serve users, operators, developers, API consumers, internal services, automated jobs, or future work that relies on a documented contract.

Keep one observable capability together when it has meaningful user, product, or platform value on its own, even if it spans files, layers, packages, modules, or components. Split only when each resulting issue can be completed, verified, reviewed, and used independently, or differs materially in risk, ownership, sequencing, or release timing.
