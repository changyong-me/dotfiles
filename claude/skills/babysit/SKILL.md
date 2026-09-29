---
name: babysit
description: Open a PR and loop with a subagent reviewer until no findings remain, then file follow-up issues and report one-way doors and blast radius.
disable-model-invocation: true
---

PR을 올리고 리뷰어 서브에이전트를 스폰해서 리뷰받아줘. 파인딩 중 타당하지 않은 건 제외하고, 이 PR에서 처리하면 좋겠다 싶은 건 수정해줘. 더 수정할 게 없을 때까지 동일한 리뷰어에게 재리뷰를 받고 수정하는 걸 반복해줘. 후속 작업이 있으면 이슈로 만들고, one-way door와 blast radius 등을 보고해줘.
