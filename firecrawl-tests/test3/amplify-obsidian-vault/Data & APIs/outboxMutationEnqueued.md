---
title: outboxMutationEnqueued
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/datastore-events/outbox-mutation-enqueued.mdx
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
- `model`:
    - `name` (String): the name of the model that is awaiting publication to the Cloud
- `element`: 
    - `model` (Model): the model instance that will be published


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/datastore-events/outbox-mutation-enqueued.mdx`