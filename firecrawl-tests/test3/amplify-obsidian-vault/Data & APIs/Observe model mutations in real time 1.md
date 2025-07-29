---
title: Observe model mutations in real time
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/native_common/real-time.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Observe model mutations in real time

## Observe model mutations in real time

You can subscribe to changes on your Models. This reacts dynamically to updates of data to the underlying Storage Engine, which could be the result of GraphQL Subscriptions as well as Queries or Mutations that run against the backing AppSync API if you are synchronizing with the cloud.

> **Note**: 
**NOTE:** AWS AppSync has an [adjustable limit of 100 subscriptions per connection](https://docs.aws.amazon.com/general/latest/gr/appsync.html). DataStore automatically subscribes to create, update, and delete mutations for all models.

This means that GraphQL APIs with DataStore enabled are limited to 33 models and DynamoDB tables.

(3 **subscriptions** * 33 **models** = 99 **subscriptions per connection**).

However, You can [request a service limit increase](https://console.aws.amazon.com/servicequotas/home/services/appsync/quotas/L-AA33EB36) from AWS AppSync to meet the real-time requirements of your application.

## Observe query results in real-time

`observeQuery(...)` returns an initial data set, similar to `query(...)`, and also automatically subscribes to subsequent changes to the query.

The first snapshot returned from `observeQuery` will contain the same results as calling `query` directly on your Model - a collection of all the locally available records. Subsequent snapshots will be emitted as updates to the dataset and received in the local store.

While data is syncing from the cloud, snapshots will contain all of the items synced so far and an `isSynced` status of `false`. When the sync process is complete, a snapshot will be emitted with all the records in the local store and an `isSynced` status of `true`.

In addition to typical real-time use cases, `observeQuery` can be used on app launch to show your customers an initial data set from the local store while new data is being synced from cloud.

`observeQuery` also accepts the same [predicates](/gen1/[platform]/build-a-backend/more-features/datastore/manipulate-data/#predicates) and [sorting](/gen1/[platform]/build-a-backend/more-features/datastore/manipulate-data/#sort) options as `query`.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/native_common/real-time.mdx`