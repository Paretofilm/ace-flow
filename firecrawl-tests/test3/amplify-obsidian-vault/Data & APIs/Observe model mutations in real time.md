---
title: Observe model mutations in real-time
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/native_common/real-time.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Observe model mutations in real-time

## Observe model mutations in real-time

You can subscribe to changes on your Models. This reacts dynamically to updates of data to the underlying Storage Engine, which could be the result of GraphQL Subscriptions as well as Queries or Mutations that run against the backing AppSync API if you are synchronizing with the cloud.

## Observe query results in real-time

`observeQuery(...)` returns an initial data set, similar to `query(...)`, and also automatically subscribes to subsequent changes to the query.

The first snapshot returned from `observeQuery` will contain the same results as calling `query` directly on your Model - a collection of all the locally-available records. Subsequent snapshots will be emitted as updates to the dataset are received in the local store.

While data is syncing from the cloud, snapshots will contain all of the items synced so far and an `isSynced` status of `false`. When the sync process is complete, a snapshot will be emitted with all the records in the local store and an `isSynced` status of `true`.

In addition to typical real-time use cases, `observeQuery` can be used on app launch to show your customers an initial data set from the local store while new data is being synced from cloud.

`observeQuery` also accepts the same [predicates](/gen1/[platform]/prev/build-a-backend/more-features/datastore/manipulate-data/#predicates) and [sorting](/gen1/[platform]/prev/build-a-backend/more-features/datastore/manipulate-data/#sort) options as `query`.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/native_common/real-time.mdx`