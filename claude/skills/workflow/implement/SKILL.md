---
name: implement
description: Implement a spec issue, deliver a reviewed draft PR, and report.
disable-model-invocation: true
---

# Implement

## The workflow

### 1. Gather the spec and pick the branch

- The input is a spec provided as an issue labeled `spec:ready`. If the issue is `spec:outline`, stop and ask for an alignment round with the `align-spec` skill instead of modifying the repository.
- Work on the branch associated with an existing PR for this spec; otherwise, create a fresh branch.

### 2. Implement the spec

- Implement the spec on the branch, using the `tdd` skill whenever the work meets its criteria, and commit the work.
- Track non-obvious decisions that materially affect the design, including the rationale, for the final report. Omit requirements, change summaries, and routine implementation details.
- Open a draft PR if none exists.

### 3. Review and report

- Run the `review` skill on the PR and provide the spec issue as the review spec; the Spec lens always runs here.
- Report the PR URL, the tracked decisions, and every finding. The report must stand alone so the user can decide without opening the PR.
