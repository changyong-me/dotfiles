---
name: tdd
description: Implement using behavior-focused red-green-refactor cycles. Use when working on behavior changes, bug fixes, regressions, or non-trivial logic.
---

1. Identify and prioritize observable behaviors to test while keeping the list flexible.
2. Write one test for the selected behavior and run it to confirm it fails.
3. Implement only enough code to pass that test and run it to confirm it passes.
4. For each remaining behavior, repeat steps 2 and 3.
5. After the selected behaviors pass, refactor while keeping tests green.

Good tests describe what the system does, not how it does it. They exercise public interfaces, use real code paths when practical, and survive internal refactors that preserve behavior.

Bad tests couple to implementation details. Avoid testing private methods, internal call counts, call order, or the shape of collaborators unless that shape is itself the public contract.

Mock only system boundaries such as external APIs, time, randomness, file systems, and sometimes databases. Do not mock internal collaborators you control.

Vertical slices test independently valuable behavior through the relevant layers. Avoid horizontal slices, imagined implementation, and speculative future features.

Refactor candidates include duplication, long methods, shallow modules, misplaced logic, primitive obsession, and existing code the new behavior exposes as problematic.
