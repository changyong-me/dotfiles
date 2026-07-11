---
name: review
description: Review code changes through three independent lenses. Use when the user asks to review a branch, PR, commit range, or diff, or to run one lens within a larger review. Skip lighter feedback requests.
---

# Review

Run three independent review lenses so each receives a focused pass: Spec, Risks, and Maintainability. Preserve overlapping findings because the lens that surfaces an issue is useful review context.

## The workflow

### 1. Gather inputs

- The input is the diff to review — a branch, commit range, PR, or working tree changes. If it cannot be inferred from the request or repository state, ask for it before starting the review.
- A spec — what the change is supposed to do: a requirements doc, issue, or prose description — may come with it. If absent, skip the Spec lens, run the other two, and report the Spec lens as skipped.

### 2. Run the review

- Spawn the subagents in parallel, one per applicable lens, and instruct each one to evaluate only its named lens section from this skill.
- Give each subagent the same review target and give the spec only to the Spec lens. Do not seed reviewers with suspected findings; their passes must remain independent.

### 3. Deliver results

- Present each lens as a separate section and preserve its findings and ordering without merging or re-ranking them.
- A lens with no findings is reported as clean, and a skipped Spec lens is reported as skipped for lack of a spec — absence must be distinguishable from silence.

## Spec lens

Does the change satisfy the provided spec without introducing unrequested user-visible behavior or contractual changes? A finding cites the requirement it violates or the scope it exceeds.

- **The yardstick:** evaluate against the provided spec. Treat unrequested user-visible behavior as a mismatch even when it seems reasonable.
- **Mismatches in both directions:** required behavior that is absent, wrong, or half-done (the main path works but the specified edge cases, limits, or error paths don't); and unrequested changes to user-visible behavior, contracts, permissions, or policy.
- **Ambiguous spec:** if multiple defensible readings would materially change the expected behavior or review verdict, report the ambiguity instead of treating one reading as authoritative.

## Risks lens

What can break at runtime because of this change? A finding identifies a concrete failure path introduced, exposed, or materially worsened by the change, including the input, state, or timing that triggers it.

- **Security:** attacker-controlled input reaching a query, command, file path, or rendered output; an operation missing the permission check its siblings have; secrets hardcoded, logged, or leaked through error responses.
- **Inputs and operating conditions:** boundary values, production-scale volumes, two executions interleaving over shared state, or an assumed order that the code does not enforce.
- **Failure paths:** state left behind by a partial failure, retries without idempotency, missing transaction boundaries, resources acquired but never released.
- **Verification gaps:** changed behavior, bug fixes, or failure paths without a test that exercises the real path; a finding explains which regression could escape the current validation.
- **Beyond the diff:** callers and shared data that still assume the old behavior, persisted data and schema migrations, API contracts of external callers, and changes only safe in one deploy order.

## Maintainability lens

What maintenance cost does the change introduce or materially worsen? A finding identifies a concrete future change or maintenance task that becomes harder or more error-prone because of the change, not a taste or unrelated pre-existing debt.

- **Code that fights its surroundings:** unidiomatic use of the language, framework, or libraries; inconsistency with the codebase's own conventions.
- **The code itself:** names that obscure intent, duplicated rules, branching more complex than the cases require, boundaries callers must reach through, tests coupled to implementation details.
- **Logic in the wrong place:** logic that primarily uses data owned by another object, deep navigation chains, layers that only delegate, one logical change scattered across many files, or one module that changes for unrelated reasons.
- **Abstractions missing or unearned:** related values without a shared type, primitives standing in for domain concepts, generality with no current use, inheritance contracts that subclasses mostly ignore.
