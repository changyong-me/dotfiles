---
name: review
description: Review code changes through three independent lenses. Use when the user asks to review a branch, PR, commit range, or diff — and when you are handed a single lens of it to run. Skip for asks lighter than a review.
---

# Review

A single reviewer told to "look at everything" spends its attention on the few most salient problems and skims the rest. So this skill narrows attention: each of three lenses — Spec, Risks, Maintainability — gets a reviewer and a full pass of its own. The perspectives are the product — even "the same issue surfaced under two lenses" is itself information.

## The workflow

### 1. Gather inputs

- The input is the diff to review — a branch, commit range, PR, or working tree changes; if missing, ask before doing anything else.
- A spec — what the change is supposed to do: a requirements doc, issue, or prose description — may come with it. The user provides it; if absent, silently skip the Spec lens and run the other two. Never ask for it.

### 2. Run the review

- Spawn the subagents in parallel, one per applicable lens, each told to run its named lens section from this skill on the target — that lens, nothing else of the skill.
- Each subagent gets the same review target, plus the spec for the Spec lens, and nothing else — a reviewer told what to suspect stops being independent.

### 3. Deliver results

- Present findings grouped by lens, in whatever form each subagent returned them — no merging, deduplication, re-ranking, or overall summary.
- A lens with no findings is reported as clean, and a skipped Spec lens is reported as skipped for lack of a spec — absence must be distinguishable from silence.

## Spec lens

Does the change do what it was asked to do? A finding points at the spec — the wording it breaks or the ask it exceeds.

- **The yardstick:** the provided spec, never what seems sensible — "reasonable but not what was asked" is a finding.
- **Mismatches in both directions:** required behavior that is absent, wrong, or half-done (the main path works but the specified edge cases, limits, or error paths don't); and behavior the spec never asked for: extra features, rules tightened or loosened.

## Risks lens

What can break at runtime? A finding needs a concrete failure path — an input, state, or timing that actually produces it.

- **Security:** input an attacker shapes reaching a query, a command, a file path, or rendered output; an operation missing the permission check its siblings have; secrets hardcoded, logged, or leaked through error responses.
- **Conditions the code never met:** untried values, production-scale volumes, two executions interleaving over shared state, an order nothing enforces.
- **Failure paths:** state left behind by a partial failure, retries without idempotency, missing transaction boundaries, resources acquired but never released.
- **Beyond the diff:** callers and shared data that still assume the old behavior, persisted data and schema migrations, API contracts of external callers, changes only safe in one deploy order — breakage sits here more often than inside the diff.

## Maintainability lens

Will the next person regret this? A finding names the cost it imposes, not a taste.

- **Code that fights its surroundings:** unidiomatic use of the language, framework, or libraries; inconsistency with the codebase's own conventions.
- **The code itself:** names that make the reader open the implementation, one rule encoded in two places, branching deeper than the cases it serves, boundaries callers must reach through, tests that won't survive refactoring.
- **Logic in the wrong place:** methods more interested in another object's data, long reach-through chains, layers that only delegate, one logical change scattered across many files or one module changing for unrelated reasons.
- **Abstractions missing or unearned:** values that always travel together, primitives standing in for domain concepts, generality nothing needs yet, inheritance its heirs mostly ignore.
