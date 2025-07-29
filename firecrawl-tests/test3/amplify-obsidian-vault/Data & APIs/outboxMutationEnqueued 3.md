---
title: outboxMutationEnqueued
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/native_common/datastore-events/outbox-mutation-enqueued.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# outboxMutationEnqueued

## outboxMutationEnqueued

Dispatched when a local change has been newly staged for synchronization with the Cloud

HubPayload `outboxMutationEvent` contains:
- `modelName` (String): the name of the model that is awaiting publication to the Cloud
- `element`: 
    - `model` (Model): the model instance that will be published


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/native_common/datastore-events/outbox-mutation-enqueued.mdx`