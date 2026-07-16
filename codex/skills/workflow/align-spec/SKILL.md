---
name: align-spec
description: Align a spec by dialogue, then break it into executable issues.
---

# Align Spec

## The workflow

### 1. Align the spec

- Map the request as a design tree in which every decision branches into the decisions that depend on it, then interview the user under the interview rules.
- Once the frontier is empty and every branch has been visited with nothing left silently assumed, present the complete shared understanding. Proceed to issue decomposition only after the user confirms it.

### 2. Decompose the spec into issues

- Inspect the code until each requirement is mapped to its implementation location and relevant dependencies; only then decompose the spec into issues.
- Split the spec into issues meeting the criteria below, so that together they cover the whole spec with no piece left unassigned. If the spec is already one executable unit, do not force a split.
- Draft each executable issue with a title, self-contained body, and label. If multiple issues need shared context, dependency tracking, or overall progress tracking, also draft an epic with all spec-wide context and the child issue titles.

### 3. Review and create the issues

- Show the user the spec and the drafted issue structure, including any epic, labels, and blocking dependencies. Iterate until the user approves the granularity, dependency graph, and any splits or merges.
- Create the approved issues in dependency order, blockers first, substituting issue numbers for dependency title references as each dependent issue is created. Then report the URLs of every created issue.

## Interview rules

- **Frontier:** treat the frontier as every decision whose prerequisites are settled. Ask the whole frontier in each round, number every question, and include a recommended answer.
- **Facts and decisions:** find facts instead of asking the user, and put each decision to the user instead of settling it by inference. When a frontier question needs a fact from the code, existing issues, or environment, spawn a subagent to investigate it.
- **Dependency handling:** defer only questions that depend on an unresolved decision or investigation, and continue with the rest of the frontier.
- **Round progression:** interview the user relentlessly, round by round. Wait for the user's answers, then incorporate completed investigations, update the tree with settled decisions and newly revealed branches, and recompute the frontier before starting the next round.

## Decomposition criteria

- **Vertical slices:** split by behavior rather than layer, including every layer needed to deliver and verify each behavior end to end.
- **Independent execution:** keep each issue small enough for one PR and independently completable and verifiable once its stated dependencies are met.
- **Explicit dependencies:** state only prerequisites that must land before the issue can be completed or verified, and explain what each one provides. Refer to each dependency by title in the draft and by issue number once created.
- **Execution mode:** apply the `agent-ready` label when an agent can complete and verify the issue without human judgment or action. Apply `human-in-the-loop` when a design decision, manual verification, credential, or unavailable external system requires a person.
