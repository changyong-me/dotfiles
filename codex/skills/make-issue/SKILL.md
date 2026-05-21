---
name: make-issue
description: Convert provided context into one or more clear, actionable software issues. Use when the user wants to turn ideas, plans, specs, debugging findings, meeting notes, implementation notes, existing issue references, or conversation context into issue tracker items without over-decomposing cohesive work.
---

# Make Issue

## Overview

Turn the user's context into the smallest useful set of actionable issues. Preserve one issue when the work is cohesive; split only when separate issues make implementation, review, testing, dependency management, or parallel work meaningfully better.

## Workflow

### 1. Gather Context

Work from all context the user provides or has already established in the conversation, including rough ideas, debugging results, design notes, plans, specs, PRDs, existing issues, pull requests, logs, or code observations.

If the user references an existing issue, PR, file, URL, or tracker item and the relevant tools are available, read the referenced material before drafting. If the codebase matters, inspect enough of it to use the project's real vocabulary and avoid inventing architecture.

### 2. Decide Whether to Split

Default to a single issue when the work has one coherent goal and can reasonably be implemented, reviewed, tested, and merged together.

Split the work only when there is a clear reason:

- The pieces deliver independently useful behavior.
- The pieces can be verified independently.
- One piece blocks another in a real dependency chain.
- The work crosses ownership boundaries that should be reviewed separately.
- The size or uncertainty would make a single issue hard to complete well.
- Parallel implementation would be practical and reduce delivery time.

Do not split merely because different layers are involved. Avoid horizontal issues such as "database work," "API work," and "frontend work" unless the user's actual workflow or ownership model makes that separation necessary.

### 3. Draft the Issue or Issues

Use the repository or tracker's existing issue conventions when they are known. If no convention is available, choose a practical structure that fits the issue.

Make the issue useful to someone who will implement it later. Account for:

- A specific title.
- The context that matters.
- The desired change or outcome.
- Relevant constraints or decisions from the provided context.
- A recognizable way to tell the issue is complete.
- Real dependencies, when they exist.

If a decision is genuinely unresolved and changes the issue's scope, ask the user before finalizing instead of burying the uncertainty in the issue body.

Avoid file paths, code snippets, or implementation instructions that are likely to go stale. Include them only when they are necessary to preserve a concrete technical decision from the provided context.

### 4. Review and Create

Show the drafted issues to the user before creating them in an issue tracker. Include the proposed titles and any meaningful split or dependency reasoning.

After the user approves the drafts, create the issues in the tracker. Create dependent issues in order so blocking issue identifiers can be referenced accurately.

If the user only asks for drafts, return the drafts without creating tracker issues. If no issue tracker tool is available, provide clean Markdown drafts the user can paste into the tracker.

Do not close, rewrite, or modify parent/source issues unless the user explicitly asks for that.
