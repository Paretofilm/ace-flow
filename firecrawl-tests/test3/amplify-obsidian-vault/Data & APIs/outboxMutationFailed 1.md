---
title: outboxMutationFailed
topics: ['Data & APIs', 'AI & Machine Learning']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/datastore-events/outbox-mutation-failed.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[AI & Machine Learning/]]
**Primary**: [[Data & APIs/]]

---


# outboxMutationFailed

## outboxMutationFailed

Dispatched when publishing a mutation fails

HubPayload `outboxMutationFailed` contains:
- `modelName` (String): the name of the model that failed to publish
- `element`:
    - `model` (Model): the model instance that failed to publish
    - `errorType` (MutationErrorType): error type that occurred
    - `operation` (MutationType): type of mutation that failed


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[AI & Machine Learning/]]

## 📖 Source
Original: `fragments/lib/datastore/android/datastore-events/outbox-mutation-failed.mdx`