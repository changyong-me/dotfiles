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

Signal quality decides diagnosis quality. Refine the loop until it matches the exact symptom, fails for the original scenario, runs repeatedly, and is stable enough to guide decisions.

Flakiness is a reproduction-rate problem. Keep increasing the frequency and observability of the failure until it is frequent enough to compare hypotheses against.

Hypotheses are predictions. Rank 3-5 theories before testing, and keep only theories that say what would change if they were true.

Instrumentation should discriminate. Choose the smallest probe that separates competing hypotheses, and measure performance regressions before changing code.

Regression tests encode the real failure. Write them before the fix when a correct seam exercises the call-site behavior; if no correct seam exists, document that as architectural information instead of writing a misleading test.

Done means the evidence changed. Rerun the feedback loop and regression test, remove temporary probes, delete or isolate throwaway harnesses, and state the hypothesis that proved correct.
