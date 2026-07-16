---
name: align-spec
description: Align a spec by dialogue, then break it into executable issues.
---

# Align Spec

## The workflow

### 1. Inspect the code, start the spec file

- Inspect the code and existing issues needed to understand the current behavior affected by the request.
- Start a spec file in a temporary location as working memory, not a repo artifact. Seed it with the current understanding of the request and revise it through questions.

### 2. Converge by questioning

- Ask only about unresolved choices that materially affect scope, behavior, edge cases, or acceptance criteria.
- Record each agreement in the file immediately, before the next question. If a point cannot be settled now, record it as explicitly unresolved.
- Consider the spec converged only when no remaining question would change it and the user has reviewed the complete spec and explicitly approved proceeding.

### 3. Decompose the spec into issues

- Inspect the code beyond the initial pass until each requirement is mapped to its implementation location and relevant dependencies; only then decompose the spec into issues.
- Split the spec into issues meeting the criteria below, so that together they cover the whole spec with no piece left unassigned. If the spec is already one executable unit, do not force a split.
- Draft each executable issue with a title, self-contained body, and label. If multiple issues need shared context, dependency tracking, or overall progress tracking, also draft an epic with all spec-wide context and the child issue titles.

### 4. Get approval, then create

- Show the user the spec and the drafted issue structure, including any epic and dependencies between issues, and get approval before creating issues. Include unresolved points explicitly in the approval request.
- On approval, create the approved issues, then report the URLs of all created issues.

## Decomposition criteria

- **Vertical slices:** split by behavior rather than layer, including every layer needed to deliver and verify each behavior end to end.
- **Independent execution:** keep each issue small enough for one PR and independently completable and verifiable once its stated dependencies are met.
- **Explicit dependencies:** state only prerequisites that must land before the issue can be completed or verified, and explain what each one provides. Refer to each dependency by title in the draft and by issue number once created.
- **Execution mode:** apply the `agent-ready` label when an agent can complete and verify the issue without human judgment or action. Apply `human-in-the-loop` when a design decision, manual verification, credential, or unavailable external system requires a person.
