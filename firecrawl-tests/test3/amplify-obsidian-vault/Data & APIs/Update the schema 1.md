---
title: Update the schema
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/native_common/schema-updates.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Update the schema

## Update the schema

Edit the schema located at `amplify/backend/api/<your-api-name>/schema.graphql` and re-run `amplify codegen models`.

```graphql
enum PostStatus 

type Post @model 
```

This will evaluate the changes and create a versioned hash if any changes are detected which impact the underlying on-device storage structure. For example, types being added/deleted or fields becoming required/optional. DataStore evaluates this version on startup and if there are changes the **local items on device will be removed and a full sync from AppSync will take place** if you are syncing with the cloud.

## Local migrations

Local migrations (i.e. migrations controlled by the developer) on device are not currently supported. Therefore, your local data will be lost when the schema changes.

If you are syncing with the cloud the structure and items of that **data in your AppSync backend will not be touched** as part of this process.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/native_common/schema-updates.mdx`