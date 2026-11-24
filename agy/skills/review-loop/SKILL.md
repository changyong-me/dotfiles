---
name: review-loop
description: Review and fix until nothing is left to fix. Use when the user wants a review loop.
---

수정할 파인딩이 나오지 않을 때까지 리뷰와 수정을 반복한다. 라운드마다 새로운 서브에이전트를 스폰해 리뷰하고 파인딩을 보고하게 한다. 서브에이전트의 모델은 GPT 6.2 Sol High를 사용한다. 파인딩 중 타당하지 않은 것은 기각하고 범위 밖이거나 사소한 것은 후속 작업으로 보고한다. 남은 파인딩은 작업하던 세션에서 수정하게 한다.
