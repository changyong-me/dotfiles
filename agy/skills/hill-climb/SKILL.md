---
name: hill-climb
description: Iterate until the work meets the target. Use when the user wants to hill-climb.
---

채점 대상을 확인하고 채점 카테고리를 정한다. 모든 카테고리에서 평균 점수가 주어진 목표를 달성할 때까지 채점과 개선을 반복한다. 라운드마다 새로운 서브에이전트를 스폰해 블라인드 채점하고 개선점을 제안하게 한다. 서브에이전트의 모델은 Gemini 4 Neon High, Claude Opus 5.5 High, GPT 6.2 Sol High를 사용한다. 개선점 중 타당한 것을 채택해 작업하던 세션에서 자유롭게 개선하게 한다.
