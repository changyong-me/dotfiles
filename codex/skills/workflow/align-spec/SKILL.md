---
name: align-spec
description: Align a spec by dialogue, then break it into executable issues.
---

# Align Spec

A spec converges twice before it becomes work: with the user — a spec written in one shot encodes the writer's assumptions — and with the code — the split into issues is a claim ("this can land as one PR") that only reading the code can back. The agent's memory does not survive a long alignment; the spec file does, so the conversation always builds on the file, not on recollection.

## The workflow

### 1. Skim the code, start the spec file

- Skim the code and issues the request touches, so questions cite current behavior.
- Start a spec file in a temporary location — working memory, not a repo artifact — seeded with the request as you now understand it; the questions exist to correct that draft.

### 2. Converge by questioning

- Ask about whatever would change the spec: scope in and out, behavior, edge cases.
- Ask one question at a time and wait for the answer — earlier answers change or eliminate later questions.
- Record each agreement in the file immediately, before the next question. If a point cannot be settled now, record it as explicitly unresolved.
- Converged means no question remains whose answer would change the spec, and the user, shown the complete spec, explicitly says to proceed.

### 3. Decompose the spec into issues

- Explore the code deeper than the opening skim — until you know where each piece of the spec would land and what those places depend on.
- Split the spec into issues meeting the criteria below, so that together they cover the whole spec — no piece left unassigned. If the spec is already one executable unit, do not force a split.
- Draft each issue in full: title, a body that links back to the spec issue, and its label.

### 4. Get approval, then create

- Show the user the spec and the drafted issues with their ordering, and get approval before creating anything — the user must accept any unresolved points as part of the spec.
- On approval, publish the spec as an issue first: replace the source issue's body if the alignment started from one, create a new issue otherwise. For a split it doubles as the umbrella, listing the child issues.
- Create the child issues in dependency order — so an issue can reference what it depends on by number — and report all URLs.
- If the spec was a single executable unit, the spec issue itself is the deliverable.

## Decomposition criteria

- **Independently executable:** each issue is completable and verifiable without waiting on a sibling, roughly one PR in size.
- **Cut along a behavior:** through layers as needed — never a layer half (a "backend issue" plus a "UI issue") that only verifies together.
- **Dependencies stated in the issues themselves:** what must land first, referenced by title in the draft and by issue number once created.
- **Labeled:** `agent-ready` (an agent can complete and verify it with no human judgment in the middle) or `human-in-the-loop` (a taste or design call, human-eyes verification, or an action only a human can take — credentials, external systems).
