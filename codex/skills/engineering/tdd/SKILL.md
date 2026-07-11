---
name: tdd
description: Drive implementation with strict test-driven development. Use whenever implementing or changing code with testable behavior, or reviewing or writing tests, even if the user doesn't mention tests. Skip for throwaway prototypes and changes with nothing to test.
---

# TDD

Implement each requested behavior in a short Red–Green–Refactor cycle. Define the behavior through the real interface before writing its implementation so the test guides the design.

## The workflow

### 1. Before the first cycle

- If the project has no test suite, set up a minimal configuration with the language's standard test runner before the first cycle.
- Break the requested feature into a short list of behaviors, ordered from simplest (degenerate/empty cases) to richest. For a bugfix, express each behavior as a reproduction test that fails on the bug and passes once it is fixed.

### 2. Red — write one failing test

- Pick the next smallest behavior and express it with one focused test through the real interface.
- Run the new test before implementation and confirm that it fails for the expected reason (assertion failure or missing symbol), not an unrelated setup error.

### 3. Green — make it pass with the minimum

- Make the smallest implementation change that makes the failing test and all existing tests pass. Leave future behavior for its own cycle.
- Run the full test suite when practical. If it is too expensive or unavailable, run the broadest relevant regression suite and report the limitation. Confirm that the selected validation passes before proceeding.

### 4. Refactor — settle the debt on green

- Inspect the new code, the existing code affected by the behavior, and the tests for debt left by the smallest change that reached Green: duplication, hardcoded shortcuts, names that lie.
- Settle what the inspection finds — improve names, remove duplication, extract structure — and run the tests after each step. Correct or undo a step that causes a regression before continuing.
- Keep refactoring limited to structure. Record newly discovered behavior for the next Red cycle instead of adding it during refactoring.
- Then go back to Red (step 2) for the next behavior in the list; stop when the list is empty.

## Good tests

A test suite exists to give one signal: red means a behavior broke; green means behaviors are intact. Every quality below protects that signal.

- **The assertion:** observable outcomes, not implementation — return values, state changes visible through the interface, emitted events, side effects at real boundaries. The acid test: could you rename internals, merge classes, or restructure modules without touching this test?
- **The call path:** use the real interface through which production callers reach the code — public API, HTTP endpoint, CLI, or module boundary. Prefer integration-style tests with real internal collaborators wired together; isolate the behavior, not the class.
- **One behavior per test:** a failure should point at the broken behavior without reading the test body.
- **Doubles:** prefer fakes or stubs at external or nondeterministic boundaries such as third-party APIs, networks, clocks, randomness, and payment providers. Use real internal collaborators unless isolation is necessary to express the behavior reliably.

## Bad tests

Each of these corrupts the red/green signal — it goes red when nothing broke, stays green when something did, or fails so noisily that nobody trusts it.

- **Implementation-coupled:** asserts on internal call sequences, private state, or conversations between mocked internal collaborators; verifying through a side channel (querying the database instead of reading back through the interface) is the same coupling.
- **Tautological:** restates its own setup — stub a mock to return X, assert the result is X; or copy the production formula into the expected value. Expected values come from an independent source of truth: a known-good literal, a worked example, the spec.
- **Flaky:** depends on wall-clock time, sleeps, execution order, shared mutable state, or live networks. Treat flaky tests as defects; isolate their effect when necessary and address the cause within the authorized scope.
- **Speculative and over-specified:** covers behavior nobody asked for, or pins incidental details (exact error strings, non-contractual ordering, full-object snapshot equality).

## Mocking and seams

A seam is the place where a test can swap a real dependency for a controlled one without editing the code under test — and seams have to be built.

- **Wrap what you don't own:** prefer a thin interface you own (a port/adapter or gateway class) over scattered third-party SDK calls. Use that interface as the seam so tests depend on application-owned types rather than vendor types.
- **Inject time and randomness:** code that calls the system clock or a global RNG directly has no seam — take a clock/RNG (or the current time/seed) as a parameter or constructor dependency.
- **Prefer fakes over interaction mocks:** a fake is a working lightweight implementation (in-memory repository, fake payment gateway with real balance logic); tests still assert on outcomes. Reserve interaction-verifying mocks ("was `charge()` called with X?") for cases where the interaction is the observable outcome (e.g., "sends exactly one notification").
- **Keep fakes honest:** a fake that drifts from the real implementation makes every test that uses it lie; when a fake underpins many tests, run one shared contract suite against both it and the real adapter.
- **No seam is design feedback:** needing to mock deep internals or patch module globals indicates a missing boundary. Introduce the seam first (extract the dependency, inject it), then test through it.
