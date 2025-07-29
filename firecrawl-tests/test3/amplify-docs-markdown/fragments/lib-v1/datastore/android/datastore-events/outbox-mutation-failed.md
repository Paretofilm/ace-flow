---
title: outboxMutationFailed
source: fragments/lib-v1/datastore/android/datastore-events/outbox-mutation-failed.mdx
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
