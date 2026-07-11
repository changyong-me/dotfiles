---
name: tdd
description: Drive implementation with strict test-driven development. Use whenever implementing or changing code with testable behavior, or reviewing or writing tests, even if the user doesn't mention tests. Skip for throwaway prototypes and changes with nothing to test.
---

# TDD

TDD is not "code with tests attached" — it is using tests as a design tool. Each cycle forces you to define behavior through the real interface before writing implementation, so the tests drive the design rather than merely check it afterward. This only works in small steps: a cycle covers one behavior and takes minutes, not hours.

## The workflow

### 1. Before the first cycle

- If the project has no test suite, set up the language's standard runner minimally before the first cycle.
- Break the requested feature into a short list of behaviors, ordered from simplest (degenerate/empty cases) to richest. For a bugfix, the behaviors are reproductions — tests that fail on the bug and pass once it is fixed.

### 2. Red — write one failing test

- Pick the next smallest behavior. Write exactly one test for it, through the real interface.
- Run it and watch it fail — a test you never saw fail proves nothing. Confirm it fails for the expected reason (assertion failure or missing symbol), not an unrelated setup error.

### 3. Green — make it pass with the minimum

- Write the least code that makes the failing test (and all existing tests) pass. If a future behavior matters, it gets its own cycle.
- Run the full test suite, not just the new test. All green means go to Refactor (step 4) — the cycle is not done yet.

### 4. Refactor — settle the debt on green

- Green's least-code rule leaves debt behind. Inspect the new code, the existing code the behavior touched, and the tests: duplication, hardcoded shortcuts, names that lie.
- Settle what the inspection finds — improve names, remove duplication, extract structure — running the tests after each step; red means revert or fix immediately.
- Refactoring changes structure only. If you notice missing behavior, note it as the next cycle's Red — don't sneak it in here.
- Then go back to Red (step 2) for the next behavior in the list; stop when the list is empty.

## Good tests

A test suite exists to give one signal: red means a behavior broke; green means behaviors are intact. Every quality below protects that signal.

- **The assertion:** observable outcomes, not implementation — return values, state changes visible through the interface, emitted events, side effects at real boundaries. The acid test: could you rename internals, merge classes, or restructure modules without touching this test?
- **The call path:** the real interface, the way production callers reach the code — public API, HTTP endpoint, CLI, module boundary. Integration-style is the default — real internal collaborators wired together; the unit of isolation is the behavior, not the class.
- **One behavior per test:** a failure should point at the broken behavior without reading the test body.
- **Doubles:** only at boundaries you don't own — third-party APIs, network, clock, randomness, payment providers get fakes or stubs; internal collaborators of the code under test never get mocked.

## Bad tests

Each of these corrupts the red/green signal — it goes red when nothing broke, stays green when something did, or fails so noisily that nobody trusts it.

- **Implementation-coupled:** asserts on internal call sequences, private state, or conversations between mocked internal collaborators; verifying through a side channel (querying the database instead of reading back through the interface) is the same coupling.
- **Tautological:** restates its own setup — stub a mock to return X, assert the result is X; or copy the production formula into the expected value. Expected values come from an independent source of truth: a known-good literal, a worked example, the spec.
- **Flaky:** depends on wall-clock time, sleeps, execution order, shared mutable state, or live networks. Quarantine and fix immediately — a suite whose reds get rerun or ignored has no signal left.
- **Speculative and over-specified:** covers behavior nobody asked for, or pins incidental details (exact error strings, non-contractual ordering, full-object snapshot equality).

## Mocking and seams

A seam is the place where a test can swap a real dependency for a controlled one without editing the code under test — and seams have to be built.

- **Wrap what you don't own:** don't scatter third-party SDK calls through the codebase; put them behind a thin interface you own (a port/adapter, a gateway class) — that interface is the seam, and tests double your interface, never the vendor's types.
- **Inject time and randomness:** code that calls the system clock or a global RNG directly has no seam — take a clock/RNG (or the current time/seed) as a parameter or constructor dependency.
- **Prefer fakes over interaction mocks:** a fake is a working lightweight implementation (in-memory repository, fake payment gateway with real balance logic); tests still assert on outcomes. Interaction-verifying mocks ("was `charge()` called with X?") couple the test to the conversation — acceptable only when the interaction is the observable outcome (e.g., "sends exactly one notification").
- **Keep fakes honest:** a fake that drifts from the real implementation makes every test that uses it lie; when a fake underpins many tests, run one shared contract suite against both it and the real adapter.
- **No seam is design feedback:** needing to mock deep internals or patch module globals means the boundary is missing, not that you need a more powerful mocking library. Introduce the seam first (extract the dependency, inject it), then test through it.
