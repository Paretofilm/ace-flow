---
title: Available Operation Types
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/data-modeling/disable-operations/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Available Operation Types

The `disableOperations` method allows you to selectively disable specific GraphQL operations for a model in your Amplify application. This can be useful for implementing specialized API designs and reduce the number of resources being deployed.

You can disable operations by adding the `disableOperations` method to your model definition:

```ts title="amplify/data/resource.ts"

## Available Operation Types

The `disableOperations` method accepts an array of operation types that you want to disable:

### General Operation Categories

- `mutations`: Disables all mutation operations (create, update, delete)
- `subscriptions`: Disables all real-time subscription operations (onCreate, onUpdate, onDelete)
- `queries`: Disables all query operations (get, list)

### Specific Operations
You can also disable more granular operations:
Query Operations

- `get`: Disables the ability to fetch a single item by ID
- `list`: Disables the ability to fetch multiple items

### Mutation Operations

- `create`: Disables the ability to create new items
- `update`: Disables the ability to update existing items
- `delete`: Disables the ability to delete items

### Subscription Operations

- `onCreate`: Disables real-time notifications when items are created
- `onUpdate`: Disables real-time notifications when items are updated
- `onDelete`: Disables real-time notifications when items are deleted

You can specify one or more operation types in the array to disable them:

```
// Disable all mutations
disableOperations: ["mutations"]

// Disable both subscriptions and queries
disableOperations: ["subscriptions", "queries"]

// Disable specific operations
disableOperations: ["create", "update", "list"]

// Disable specific subscription types
disableOperations: ["onCreate", "onUpdate"]

// Mix general categories with specific operations
disableOperations: ["queries", "create", "onDelete"]
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/data-modeling/disable-operations/index.mdx`