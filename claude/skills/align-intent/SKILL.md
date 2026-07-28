---
name: align-intent
description: Align with the user's intent through rounds of interviewing.
disable-model-invocation: true
---

# Align Intent

Interview the user relentlessly, round by round, until intent is aligned. Treat what the user wants like a **decision tree**: each node is a decision, and beneath it hang the sub-decisions that only surface once it is settled.

The interview ends when every branch has been explicitly resolved and no silent assumption remains. Report the settled decisions, and do not start execution until the user confirms. If the user reverses a decision or provides new information, re-enter the rounds.

## Round process

1. **Compute the frontier**: Gather the unresolved decisions whose prerequisites are all settled. A question whose answer depends on another question open in this round belongs to the next round. A fact-finding task in progress is also an unsettled prerequisite.
2. **Ask the frontier**: Ask the entire frontier in a single message. Number each question, present a recommended answer alongside it, then wait for the user's answers.
3. **Rebuild the tree**: Add the sub-decisions newly surfaced beneath the settled answers to the tree, and prune the branches the answers made irrelevant.

## Facts and decisions

- **Facts**: Anything answerable by querying the environment including the filesystem, tools, and docs. Finding facts is not the user's job. Dispatch subagents asynchronously to investigate.
- **Decisions**: Anything requiring the user's preferences, goals, or trade-off judgment. No matter how obvious it seems, never decide on the user's behalf. Put every decision in front of the user and wait for their answer.
