---
name: resolve-issue
description: Resolve AFK GitHub issues by inspecting issue intent, processing each issue sequentially through a dedicated subagent, requiring each subagent to use relevant skills, validate, and commit, then opening or updating a PR that closes the issues when merged.
---

# Resolve Issue

## Overview

Complete one or more AFK GitHub issues without further human decisions. Confirm the issue details, delegate each issue to a dedicated subagent in sequence, require a commit per issue, and finish by pushing to an existing PR or opening a new one.

## Workflow

1. Inspect the requested GitHub issue or issue list before doing implementation work. Read titles, bodies, comments, labels, linked PRs, milestones, and close relationships; stop for the user if any issue is HITL, blocked by access, or missing essential intent.

2. Handle issues one at a time in the chosen order. For each issue, spawn exactly one subagent with the issue URL or number plus any context found during inspection, and require validation and a commit.

3. Wait for each subagent to finish before starting the next issue. Review its summary, commit, diff, and validation output; fix only coordination problems in the parent thread, and keep implementation responsibility with the issue's subagent whenever practical.

4. After all issues are committed, push the branch. If already on a PR branch, update that PR; otherwise open a PR with closing keywords for every resolved issue so GitHub closes them on merge, and include the validation results in the handoff to the user.

## Subagent Model

Subagents are the implementation unit for each resolved issue. Use one subagent per issue so ownership, commits, validation, and failure boundaries stay clear; do not batch multiple issues into one worker unless the issues are inseparable and the user accepts the combined scope.

Each subagent should read its assigned issue, inspect relevant skills and project instructions, then gather context needed for that issue. It should use applicable skills actively, implement the fix, validate it, commit it, and report the summary, diff, commit, and validation output.
