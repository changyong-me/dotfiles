---
name: review
description: Review code changes through three independent lenses. Use when the user requests a formal code review or when required by other workflows.
---

# Review

## The workflow

### 1. Gather inputs

- The input is the diff to review: a branch, commit range, PR, or working tree changes. If it cannot be inferred from the request or repository state, ask for it before starting the review.
- A requirements document, issue, or prose description may be provided as the spec for what the change is supposed to do. If no spec is provided, skip the Spec lens, run the other two, and report the Spec lens as skipped.

### 2. Run the review

- Spawn the subagents in parallel, one per applicable lens, and instruct each one to evaluate only its named lens section from this skill.
- Give each subagent the same review target and available spec. Do not seed reviewers with suspected findings; their passes must remain independent.

### 3. Deliver results

- Present each lens as a separate section and preserve its findings and ordering without merging or re-ranking them.
- A lens with no findings is reported as clean, and a skipped Spec lens is reported as skipped for lack of a spec; absence must be distinguishable from silence.

## Spec lens

Does the change satisfy the provided spec without introducing unrequested user-visible behavior or contractual changes? A finding cites the requirement it violates or the scope it exceeds.

- **Ambiguity:** multiple defensible readings that would materially change the expected behavior or review verdict; report the ambiguity rather than choosing one as authoritative.
- **Requirements:** required behavior that is absent, partial, or appears implemented but produces the wrong result for a reachable input, state, boundary, or failure path.
- **Scope:** unrequested changes to user-visible behavior, contracts, permissions, or policy, even when they seem reasonable.
- **Documentation:** documentation, examples, or repository guidance within the change's scope that now contradict the specified behavior or architecture.

## Risks lens

What can break at runtime because of this change? A finding traces a reachable input, state, or timing condition to an incorrect outcome and shows how the change creates, makes reachable, or materially worsens that failure path. An unverified scenario is not enough.

- **Security:** attacker-controlled inputs, authorization boundaries, or sensitive data flows that the change leaves exploitable or exposed.
- **Operating conditions:** input, scale, timing, concurrency, or ordering conditions that reach a wrong outcome because the code assumes constraints it does not enforce.
- **Failure handling:** partial failures, retries, transaction boundaries, or cleanup paths that leave incorrect state or unreleased resources.
- **Integration:** callers, persisted data, external contracts, migrations, or deploy ordering that still depend on the old behavior.
- **Verification gaps:** changed behavior or a concrete failure path not exercised by existing validation; a finding identifies the specific regression that could escape, not merely the absence of a dedicated test.

## Simplicity lens

What unnecessary complexity does the change introduce or materially worsen? A finding shows how to simplify it without changing required behavior. Future needs, taste, minor cleanup, and unrelated pre-existing complexity are not enough.

- **Reuse and consolidation:** functionality reimplemented despite an existing facility, or nontrivial rules repeated across paths, when one implementation would preserve behavior without adding equal or greater indirection.
- **Design surface:** layers or contracts that materially enlarge the design surface without serving a current requirement, invariant, real boundary, or mitigation of a concrete risk.
- **State and work:** runtime state or work that a direct path can remove while preserving the result and required operating characteristics.
