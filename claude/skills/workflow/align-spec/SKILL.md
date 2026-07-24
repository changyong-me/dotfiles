---
name: align-spec
description: Align a spec by dialogue, then open it as a spec issue.
disable-model-invocation: true
---

# Align Spec

## The workflow

### 1. Align the spec

- Map the request as a design tree in which every decision branches into the decisions that depend on it, then interview the user under the interview rules.
- When the input is an area of an existing `spec:outline` issue, root the tree at that area, treat the outline's already-settled decisions as prerequisites instead of reopening them, and reconfirm an outline decision only when the interview surfaces evidence against it.
- Once the frontier is empty and every branch has been visited with nothing left silently assumed, present the complete shared understanding. Proceed only after the user confirms it.

### 2. Determine the spec state

- Propose `spec:ready` when every branch is settled and the spec is aligned enough to implement without further alignment.
- Propose `spec:outline` when the overall shape is agreed but some subtrees were deliberately deferred. Draft the body in two parts: the agreed outline, and a list of deferred areas that each need their own alignment round.

### 3. Review and create the issue

- Show the user the drafted issue body and the proposed label. Iterate until the user approves both.
- Create one issue and report its URL. When the spec aligns an area of a `spec:outline` issue, create it as `spec:ready`, reference the outline issue from it, and update the outline issue's deferred-area list to point to the new issue.

## Interview rules

- **Frontier:** treat the frontier as every decision whose prerequisites are settled. Ask the whole frontier in each round, number every question, and include a recommended answer.
- **Facts and decisions:** find facts instead of asking the user, and put each decision to the user instead of settling it by inference. When a frontier question needs a fact from the code, existing issues, or environment, spawn a subagent to investigate it.
- **Dependency handling:** defer only questions that depend on an unresolved decision or investigation, and continue with the rest of the frontier.
- **Round progression:** interview the user relentlessly, round by round. Wait for the user's answers, then incorporate completed investigations, update the tree with settled decisions and newly revealed branches, and recompute the frontier before starting the next round.
