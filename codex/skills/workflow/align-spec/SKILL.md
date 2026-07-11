---
name: align-spec
description: Align a spec by dialogue, then break it into executable issues.
---

# Align Spec

Maintain the evolving spec in a temporary file as the source of truth. Align it first with the request, then with the codebase before decomposing it into executable issues.

## The workflow

### 1. Inspect the code, start the spec file

- Inspect the code and existing issues needed to understand the current behavior affected by the request.
- Start a spec file in a temporary location as working memory, not a repo artifact. Seed it with the current understanding of the request and revise it through questions.

### 2. Converge by questioning

- Ask only about unresolved choices that materially affect scope, behavior, edge cases, or acceptance criteria.
- Ask one question at a time and wait for the answer — earlier answers change or eliminate later questions.
- Record each agreement in the file immediately, before the next question. If a point cannot be settled now, record it as explicitly unresolved.
- Consider the spec converged only when no remaining question would change it and the user has reviewed the complete spec and explicitly approved proceeding.

### 3. Decompose the spec into issues

- Inspect the code beyond the initial pass until each requirement is mapped to its implementation location and relevant dependencies; only then decompose the spec into issues.
- Split the spec into issues meeting the criteria below, so that together they cover the whole spec — no piece left unassigned. If the spec is already one executable unit, do not force a split.
- Draft each issue in full: title, a body that links back to the spec issue, and its label.

### 4. Get approval, then create

- Show the user the spec and the drafted issues with their ordering, and get approval before creating or modifying GitHub issues. Include unresolved points explicitly in the approval request.
- On approval, publish the spec as an issue first: replace the source issue's body if the alignment started from one, create a new issue otherwise. If the spec is split, the spec issue also serves as the umbrella and lists the child issues.
- Create the child issues in dependency order — so an issue can reference what it depends on by number — and report all URLs.
- If the spec was a single executable unit, the spec issue itself is the deliverable.

## Decomposition criteria

- **Independently executable:** each issue is completable and verifiable without waiting on a sibling, roughly one PR in size.
- **Cut along a behavior:** prefer behavior-complete issues that can be verified independently; avoid splitting layers that only become testable when combined.
- **Dependencies stated in the issues themselves:** what must land first, referenced by title in the draft and by issue number once created.
- **Labeled:** `agent-ready` (an agent can complete and verify it with no human judgment in the middle) or `human-in-the-loop` (a taste or design call, human-eyes verification, or an action only a human can take — credentials, external systems).
