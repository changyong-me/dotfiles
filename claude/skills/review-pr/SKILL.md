---
name: review-pr
description: Review a PR with three reviewer subagents in parallel.
disable-model-invocation: true
---

# Review PR

Review the PR with three reviewer subagents in parallel, each asking one question: spec asks whether the change does what was asked, correctness whether it breaks, and simplicity whether it is more complex than it needs to be.

## Process

1. Find the PR and the spec. Ask the user for whichever is missing; if the user confirms there is no spec, skip the spec review.
2. Dispatch the three reviewer subagents in parallel. Brief each with its review prompt below in full, and references to the PR and the spec.
3. Present the three reports separately; do not merge or rerank their findings. Note the spec review as skipped when there was no spec.

## Review prompts

- **Spec**: Compare the change against what the spec asked for. Report requirements that are missing or partially implemented, behavior the spec did not ask for, and requirements implemented differently from what the spec describes. Quote the spec for each finding.
- **Correctness**: Search for inputs, states, and timings under which the introduced code produces wrong results or breaks. Look for unhandled edge inputs, races, state left corrupted after partial failure, swallowed errors, and security flaws, among others. For each finding, name a concrete failure scenario.
- **Simplicity**: Find unnecessary complexity the change added, such as single-implementation abstractions, unused flexibility, premature generalization, duplication, or derivable state. For each finding, name a simpler form that does the same thing.
