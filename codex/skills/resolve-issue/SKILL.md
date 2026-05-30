---
name: resolve-issue
description: Resolve AFK GitHub issues by inspecting the issues first, gathering repository context, processing each issue sequentially through a dedicated subagent, ensuring each subagent uses relevant skills and commits its implementation, then opening or updating a PR that closes the issues when merged.
---

# Resolve Issue

## Overview

Use this skill to complete one or more AFK GitHub issues without further human decisions. Confirm the issue details, gather repository context, delegate each issue to a dedicated subagent in sequence, require a commit per issue, and finish by pushing to an existing PR or opening a new one.

## Workflow

1. Inspect the requested GitHub issue or issue list before doing implementation work. Read titles, bodies, comments, labels, linked PRs, milestones, and close relationships; stop for the user if any issue is HITL, blocked by access, or missing essential intent.

2. Gather context from repository guidance, existing skills, nearby code, tests, docs, and recent history. Determine the branch state, whether the current checkout already belongs to a PR, and which validation commands should prove the issue is resolved.

3. Handle issues one at a time in the chosen order. For each issue, spawn exactly one subagent, pass the issue URL or number plus the gathered context, require it to inspect available skills first, use applicable skills actively, implement the fix, validate it, and commit.

4. Wait for each subagent to finish before starting the next issue. Review its summary, commit, diff, and validation output; fix only coordination problems in the parent thread, and keep implementation responsibility with the issue's subagent whenever practical.

5. After all issues are committed, push the branch. If already on a PR branch, update that PR; otherwise open a PR with closing keywords for every resolved issue so GitHub closes them on merge, and include the validation results in the handoff to the user.

## Delegation Model

Subagents are the implementation unit for this skill. Use one subagent per issue so ownership, commits, validation, and failure boundaries stay clear; do not batch multiple issues into one worker unless the issues are inseparable and the user accepts the combined scope.

Each subagent should begin by reading relevant skills and project instructions, then gather only the context needed for its issue. The parent coordinates sequencing, reviews outputs, and prepares the PR, but should avoid duplicating the subagent's work while it is running.
