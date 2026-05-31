---
name: create-issue
description: Create GitHub issues from a request, plan, discussion, or repository context by gathering evidence, decomposing only into vertical slices, classifying work as AFK or HITL, showing the proposed issue set for approval, and creating the approved issues.
---

# Create Issue

## Overview

Turn an ambiguous request or planning context into one or more GitHub issues that an agent or human can pick up. Gather enough evidence to preserve intent, split by deliverable vertical slices, classify each issue as AFK or HITL, and create issues only after user approval.

## Workflow

1. Gather context from the user request, linked docs, existing issues, project guidance, and the relevant code or product surface. Identify the target repository, branch expectations, constraints, unknowns, and any user decisions that materially change the split.

2. Decompose the work into vertical slices that produce user-visible or system-verifiable value. Decide whether the result needs one issue, sibling issues, or an epic, and mark each issue AFK or HITL.

3. Show the proposed issue set to the user before creating anything. Include concise titles, the AFK or HITL label, dependencies, validation expectations, and why each slice is independent; ask for confirmation when the split changes scope or ordering.

4. After the user approves, create the issues, link child issues to the epic when present, preserve issue dependencies where appropriate, and report the created issue URLs.

## Issue Boundaries

A vertical slice crosses the layers needed for one outcome: interface, API, domain logic, storage, tests, documentation, migration, or operations as needed. Avoid layer-only issues such as schema, UI, cleanup, or tests unless that layer is itself the complete deliverable.

Keep each issue small enough for one focused implementation pass and complete enough to validate. Use sibling issues when outcomes can ship separately, or an epic when child issues need coordination. Mark AFK when an agent can finish with context and access; mark HITL when human input is required.
