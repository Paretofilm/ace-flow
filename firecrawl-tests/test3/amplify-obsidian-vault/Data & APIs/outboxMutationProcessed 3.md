---
title: outboxMutationProcessed
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/native_common/datastore-events/outbox-mutation-processed.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# outboxMutationProcessed

## outboxMutationProcessed

Dispatched when a local change has finished synchronization with the Cloud and is updated locally

HubPayload `outboxMutationEvent` contains:
- `modelName` (String): the name of the model that has finished processing
- `element`: 
    - `model` (Model): the model instance that is processed
    - `_version` (Int): version of the model instance
    - `_lastChangedAt` (Int): last change time of model instance (unix time)
    - `_deleted` (Bool): true if the model instance has been deleted in Cloud


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/native_common/datastore-events/outbox-mutation-processed.mdx`