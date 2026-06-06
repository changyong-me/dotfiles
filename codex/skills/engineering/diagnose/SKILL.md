---
name: diagnose
description: Diagnose a bug with a disciplined feedback loop. Use when debugging reported bugs, broken or failing behavior, or performance regressions.
---

1. Build a fast, deterministic feedback loop for the reported failure.
2. Reproduce the user's exact symptom with that loop and capture the evidence.
3. Generate 3-5 ranked, falsifiable hypotheses before testing.
4. Instrument one boundary at a time to distinguish the hypotheses.
5. Add a regression test at the correct seam, then fix the cause.
6. Clean up instrumentation and report the verified cause, fix, and prevention lesson.

Feedback loops are the work. Turn uncertainty into the fastest runnable signal that reaches the failure; bisection, hypothesis testing, and instrumentation all depend on that signal.

Runnable seams make feedback loops concrete. Prefer the nearest executable seam, roughly from tests and request or CLI scripts through browser automation, trace replay, harnesses, fuzzing, bisection, and differential checks.

Signal quality decides diagnosis quality. Trust a loop only when it is fast, sharp, repeatable, stable enough to guide decisions, and failing for the original scenario with the user's exact symptom rather than a nearby crash or generic failure.

Flakiness is a reproduction-rate problem. Keep increasing the frequency and observability of the failure until it is frequent enough to compare hypotheses against.

Hypotheses are predictions. Each theory should name what evidence would strengthen it, what evidence would weaken it, and which probe will test that difference.

Instrumentation should discriminate. Change one variable at a time, choose the smallest probe that separates competing hypotheses, keep temporary probes easy to identify and remove, and measure performance regressions before changing code.

Regression tests encode the real failure. Write them before the fix when a correct seam exercises the call-site behavior; if no correct seam exists, document that as architectural information instead of writing a misleading test.

Done means the evidence changed. Rerun the feedback loop and regression test, remove temporary probes, delete or isolate throwaway harnesses, and state the hypothesis that proved correct.
