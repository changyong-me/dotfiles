---
name: create-issue
description: Create GitHub issues from a request, plan, discussion, or repository context by gathering evidence, decomposing only into vertical slices, classifying work as AFK or HITL, showing the proposed issue set for approval, and creating the approved issues with gh or configured GitHub tooling.
---

# Create Issue

## Overview

Turn an ambiguous request or planning context into one or more GitHub issues that an agent or human can pick up. Gather enough evidence to preserve intent, split by deliverable vertical slices, classify each issue as AFK or HITL, and create issues only after user approval.

## Workflow

1. Gather context first: read the user request, linked docs, existing issues, project guidance, and the relevant code or product surface. Identify the target repository, branch expectations, GitHub tooling, constraints, unknowns, and any user decisions that materially change the split.

2. Decompose the work into vertical slices that each produce user-visible or system-verifiable value. Reject horizontal slices such as only schema, only UI, only cleanup, or only tests unless they are fully self-contained deliverables with independent validation.

3. Decide whether the result needs one issue, several sibling issues, or an epic issue that coordinates child issues. Mark every issue as AFK when an agent can complete it alone, or HITL when product, design, credentials, access, or judgment from a person is required.

4. Show the proposed issue set to the user before creating anything. Include concise titles, the AFK or HITL label, dependencies, validation expectations, and why each slice is independent; ask for confirmation when the split changes scope or ordering.

5. After the user approves, create the issues with the official `gh` CLI or the repository's configured GitHub integration. Link child issues to the epic when present, preserve issue dependencies where appropriate, and report the created issue URLs.

## Vertical Slices

A vertical slice crosses the layers needed for one outcome: interface, API, domain logic, storage, tests, documentation, migration, or operations as needed. It should be small enough for one focused implementation pass yet complete enough to review, validate, and ship independently.

Avoid slices that merely assign layers or specialties to separate issues, because they create hidden dependencies and unfinished work. When a layer-only task seems unavoidable, fold it into the smallest outcome it enables or classify it as HITL if the split requires a human decision.
