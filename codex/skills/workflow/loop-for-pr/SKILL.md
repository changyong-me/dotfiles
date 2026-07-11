---
name: loop-for-pr
description: Autonomously implement an issue and deliver a reviewed PR.
---

# Loop for PR

The deliverable is not just a PR but a PR that review has nothing left to say about. The user isn't watching the loop, so the PR must carry the story: judging what happened means reading the PR, not interrogating the agent. The loop has no round cap — the main agent is the circuit breaker.

## The workflow

### 1. Gather the input, pick the branch

- The input is a spec — an `agent-ready` issue, one an agent can complete and verify with no human judgment in the middle; if missing, ask before doing anything else.
- Work on the PR branch already open for this spec if there is one, otherwise on a fresh branch.

### 2. Implement the spec

- Spawn a subagent — a fresh one each round, never the previous implementer — to implement the spec on the branch and commit its work. On fix rounds it also gets the findings to address and the decisions posted on the PR so far.
- The implementer reports every decision it made on its own, each with the why — a point the spec left open that it closed: an ambiguity read one way, a tradeoff picked among valid designs, scope added or dropped.
- Open a draft PR if none exists, and post those decisions as a comment on the PR.

### 3. Review the PR

- Run the `review` skill on the PR, with the spec issue as its spec — the Spec lens always runs here.
- Post the findings as a single conversation comment on the PR — all lenses together, one comment per round, so each round reads as one unit in the PR timeline.

### 4. Fix or finish

- Any stop signal below stops the loop: the PR stays a draft, and the report gives the user the PR, the remaining findings, and why it stopped.
- Findings left mean a fix round — back to implement the spec (step 2) with them. None left finishes it: the PR goes to the user marked ready for review.
- Either exit can come back with a decision from the user; it lands as a comment on the PR before the loop resumes.

## Stop signals

- **The loop is not converging:** a finding survives a fix round and comes back, findings stop shrinking round over round or grow, one round's fix undoes another's.
- **A finding points at a defect in the spec itself:** two requirements that cannot both hold, or wording the implementation and the finding each read their own way — with both readings defensible. No fix round settles this; only the user amending the spec does.
- **Blocked on an action only a human can take:** credentials, a deploy, an external system. The report says exactly what the user must do to unblock.
