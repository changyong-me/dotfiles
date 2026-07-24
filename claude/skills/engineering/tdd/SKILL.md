---
name: tdd
description: Drive implementation with strict test-driven development. Use when implementing non-trivial and testable behavior or fixing a reproducible bug.
---

# TDD

## The workflow

### 1. Before the first cycle

- If the project has no test suite, set up a minimal configuration with the language's standard test runner before the first cycle.
- Break the requested feature into a short list of behaviors, ordered from simplest (degenerate/empty cases) to richest. For a bugfix, express each behavior as a reproduction test that fails on the bug and passes once it is fixed.

### 2. Red: write one failing test

- Pick the next smallest behavior and express it with one focused test through the real interface.
- Run the new test before implementation and confirm that it fails for the expected reason (assertion failure or missing symbol), not an unrelated setup error.

### 3. Green: make it pass with the minimum

- Make the smallest implementation change that makes the failing test and all existing tests pass. Leave future behavior for its own cycle.
- Run the full test suite when practical. If it is too expensive or unavailable, run the broadest relevant regression suite and report the limitation.
- Once the selected validation passes, proceed to Refactor (step 4); the cycle is not complete yet.

### 4. Refactor: settle the debt on green

- Inspect the new code, affected existing code, and tests for problems left by the minimum change that reached Green: duplication, hardcoded shortcuts, and misleading names. Fix what you find, but keep the changes limited to structure.
- Run the tests after each refactoring step. Correct or undo regressions before continuing, and record newly discovered behavior for the next Red cycle instead of adding it during refactoring.
- Then go back to Red (step 2) for the next behavior in the list; stop when the list is empty.

## Test quality

A good test fails when the behavior it covers breaks and stays green while that behavior remains intact.

- **One behavior per test:** a failure should point at the broken behavior without reading the test body.
- **Production call path:** use the real interface through which production callers reach the code, such as a public API, HTTP endpoint, CLI, or module boundary. Prefer integration-style tests with real internal collaborators.
- **Observable outcomes:** assert on return values, interface-visible state changes, emitted events, or boundary side effects instead of implementation details.
- **Test doubles:** prefer fakes or stubs at external or nondeterministic boundaries such as third-party APIs, networks, clocks, randomness, and payment providers.

A bad test can pass while the behavior it covers is broken, fail while that behavior is correct, or obscure the cause of failure.

- **Tautological:** asserts a value supplied by its own stub or copies production logic into the expected result. Expected values should come from an independent source of truth such as a known-good literal, worked example, or the spec.
- **Flaky:** depends on wall-clock time, sleeps, execution order, shared mutable state, or live networks. Treat flakiness as a defect; fix the cause within the requested scope, or contain its effect when that is not possible.
- **Speculative and over-specified:** covers behavior nobody asked for, or pins details the contract does not guarantee, such as exact error text, ordering, or full-object snapshots.

## Mocking and seams

A seam is an explicit boundary where a test can replace a real dependency with a controlled one without editing the code under test.

- **Wrap external dependencies:** prefer a thin application-owned interface such as a port, adapter, or gateway over scattered third-party SDK calls. Use it as the seam so tests depend on application types rather than vendor types.
- **Inject time and randomness:** code that calls the system clock or a global RNG directly has no seam; take a clock/RNG (or the current time/seed) as a parameter or constructor dependency.
- **Prefer fakes over mocks:** a fake is a working lightweight implementation, such as an in-memory repository. Tests using fakes still assert on outcomes. Use interaction-verifying mocks only when the interaction itself is observable behavior, such as sending exactly one notification.
- **Validate shared fakes:** when a fake supports many tests, run the same contract suite against the fake and the real adapter to detect drift.
- **Learn from missing seams:** if testing requires deep internal mocks or patched globals, express the desired boundary in the failing test and introduce the smallest seam during Green.
