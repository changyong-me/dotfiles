---
name: implement
description: Implement issues or address pull request review feedback end to end. Use when the user asks Codex to implement a software issue, make code changes from an issue or spec, respond to PR review comments, fix requested changes on an existing PR, or prepare code for a new PR.
---

# Implement

## Overview

Implement the requested work as a complete engineering change: understand the issue or review feedback, inspect the real codebase and available tooling, make a concrete plan, apply the change, run the repository's quality checks, and ask before creating a PR or pushing to an existing PR branch.

## Workflow

### 1. Review the Issue or PR Feedback

Start from the source request, not from assumptions. Read the issue, PR, review comments, review threads, linked requirements, screenshots, logs, CI failures, and any conversation context the user has provided.

Decide which mode applies:

- **Issue implementation**: implement a requested change that is not yet represented by the current branch.
- **PR feedback**: update an existing PR branch to address reviewer comments or failing checks.
- **Issue plus PR feedback**: use the issue as the source of product intent and the PR feedback as the source of remaining required changes.

For PR feedback, identify each unresolved requested change and track it until it is either implemented, explicitly declined with a reason, or blocked by missing information. Do not treat a PR comment as resolved merely because nearby code changed.

### 2. Inspect the Codebase and Available Tools

Use subagents for the independent exploration tracks. Spawn them with the same model and reasoning effort as yourself.

Assign each subagent one narrow responsibility:

- **Codebase exploration**: find the relevant modules, data flow, existing patterns, ownership boundaries, tests, fixtures, and likely risk areas for the requested change.
- **Tools and skills exploration**: identify repository scripts, package manager commands, test/lint/typecheck/build commands, CI configuration, available Codex skills, MCP resources, plugins, issue/PR tooling, and any local helper workflows.

After spawning subagents, do not perform any other work while they are running. Wait indefinitely until every required subagent has completed, repeating waits as needed instead of reading files, inspecting state, planning, editing, or otherwise advancing the task in the main agent.

### 3. Build a Concrete Implementation Plan

Combine the issue or PR feedback with the exploration results before editing. The plan should identify:

- Files or modules likely to change.
- Existing patterns or helpers to reuse.
- User-visible behavior or API contracts to preserve.
- Tests or checks to add or update.
- Risks, unresolved requirements, or assumptions.

Ask the user before implementation only when the ambiguity can change the correct behavior, scope, data model, public API, or release risk. Otherwise make a conservative decision consistent with the codebase and continue.

For substantial changes, share a short plan before editing. Keep the plan specific enough that progress and tradeoffs can be evaluated against the actual repository.

### 4. Implement and Run Quality Checks

Make the smallest coherent code change that satisfies the issue or PR feedback. Follow repository patterns over new abstractions, preserve unrelated user changes, and avoid broad refactors unless they are necessary to complete the work safely.

During implementation:

- Use existing helpers, libraries, schemas, and conventions before introducing new ones.
- Update tests, fixtures, docs, or generated artifacts when the behavior requires it.
- For PR feedback, map each requested change to the code or explanation that addresses it.

Run the quality checks discovered in step 2 that reasonably apply to the change, such as formatting, linting, typechecking, unit tests, integration tests, build checks, or targeted regression commands. Prefer existing repository commands over invented one-off checks.

If a check cannot be run, fails for an unrelated pre-existing reason, or requires unavailable credentials or services, report that explicitly with the command and observed result.

### 5. Ask Before Creating a PR or Pushing

After implementation and quality checks, summarize the change, list the checks run, and ask for approval before any networked git or tracker action.

Use the right prompt for the current state:

- If there is no existing PR, ask whether to create a PR.
- If this branch already backs a PR, ask whether to commit and push the updates to that PR branch.
- If the user only asked for a local patch, do not offer to push unless it is the natural next step and the branch state is clear.

When the user approves, verify the branch, remote, changed files, and PR target before acting. Do not include unrelated user changes in commits.

After creating a PR or pushing to an existing PR, report the PR URL or pushed branch, the commit hash when available, and any remaining reviewer or CI follow-up needed.
