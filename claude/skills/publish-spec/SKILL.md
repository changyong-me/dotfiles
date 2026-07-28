---
name: publish-spec
description: Synthesize the current conversation into a spec and publish it.
disable-model-invocation: true
---

# Publish Spec

Synthesize the current conversation and codebase understanding into a spec and publish it. The spec is published with one of two labels: `spec:ready` for a spec to be implemented as is, or `spec:outline` for one to be split into sub-specs first, published as a high-level overview.

## Process

1. Explore the codebase to understand its current state, if not already explored.
2. Write the spec covering the spec contents, and judge which label fits. Then present the spec and the label. If the user asks for changes, apply them and confirm again.
3. Publish the confirmed spec to the project issue tracker with the confirmed label.

## Spec contents

- **Problem**: The problem as the user experiences it.
- **Solution**: The solution as the user will experience it.
- **User stories**: A long list of user stories that covers every actor and every behavior the feature supports.
- **Decisions**: Every decision settled in the conversation that constrains how the feature will be built or tested.
- **Out of scope**: Everything settled as out of scope in the conversation.
