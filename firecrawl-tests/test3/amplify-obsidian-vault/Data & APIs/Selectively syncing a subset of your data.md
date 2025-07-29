---
title: Selectively syncing a subset of your data
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/sync/50-selectiveSync.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Selectively syncing a subset of your data

## Selectively syncing a subset of your data

By default, DataStore fetches all the records that you’re authorized to access from your cloud data source to your local device. The maximum number of records that will be stored locally is configurable [here](/gen1/[platform]/prev/build-a-backend/more-features/datastore/conflict-resolution/).

You can utilize selective sync to persist a subset of your data instead.

Selective sync works by applying predicates to the base and delta sync queries, as well as to incoming subscriptions.

> **Note**: 

Note that selective sync is applied on top of authorization rules you’ve defined on your schema with the `@auth` directive. For more information see the [Setup authorization rules](/gen1/[platform]/prev/build-a-backend/more-features/datastore/authz-rules-setup/) section.

```js

DataStore.configure(),
    syncExpression(Comment, () => )
  ]
});
```

When DataStore starts syncing, only Posts with `rating > 5` and Comments with `status === 'active'` will be synced down to the user's local store.

> **Note**: 

Developers should only specify a single `syncExpression` per model. Any subsequent expressions for the same model will be ignored.

### Reevaluate expressions at runtime

Sync expressions get evaluated whenever DataStore starts. In order to have your expressions reevaluated, you can execute `DataStore.clear()` or `DataStore.stop()` followed by `DataStore.start()`.

If you have the following expression and you want to change the filter that gets applied at runtime, you can do the following:

```js
let rating = 5;

DataStore.configure()
  ]
});

async function changeSync() 
```

Calls to `start`, `query`, `save`, `delete`, `observe`, and `observeQuery` will only start DataStore and reevaluate sync expressions if DataStore is not already started.

In the example above, `changeSync()` invokes `DataStore.start()` after `DataStore.stop()` has completely finished. This causes sync expressions to be reevaluated. Subsequently, when the sync expression is reevaluated, the `rating` variable has been changed to `1`, so all Posts with `rating > 1` will get synced down.

Keep in mind: `DataStore.stop()` will retain the local store's existing content. Run `DataStore.clear()` to clear the locally-stored contents.

> **Note**: 

When applying a more restrictive filter, clear the local records first by running `DataStore.clear()` instead:

```js
async function changeSync() 
```

This will clear the contents of your local store, reevaluate your sync expressions and re-sync the data from the cloud, applying all of the specified predicates to the sync queries.

You can also have your sync expression return `Predicates.ALL` in order to remove any filtering for that model. This will have the same effect as the default sync behavior.

```js
let rating = null;

DataStore.configure(

      return Predicates.ALL;
    })
  ]
});
```

> **Note**: 

`DataStore.configure()` should only by called once at the root of your file.

### Async expressions

You can pass a Promise to `syncExpression`:

```js
DataStore.configure()
  ]
});
```

DataStore will wait for the Promise to resolve before applying the expression to the sync. Async expressions can also be reevaluated at runtime, just like synchronous expressions (see previous section).

### Shorthand

If you don't need to add any logic to your `syncExpression`, you can use the following shorthand, returning the predicate directly:

```js
DataStore.configure();
```

### Advanced use case - Query instead of Scan

You can configure selective sync to retrieve items from DynamoDB with a [query operation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html) against a GSI. By default, the base sync will perform a [scan](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html). Query operations enable a highly efficient and cost-effective data retrieval for customers running DynamoDB at scale. Learn about creating GSIs with the `@index` directive [here](/gen1/[platform]/build-a-backend/graphqlapi/data-modeling/).

In order to do that, your `syncExpression` should return a predicate that maps to a query expression.

For example, for the following schema:

```graphql
type User @model 
```

Both of these sync expressions will result in AWS AppSync retrieving records from Amazon DynamoDB via a query operation:

```js
DataStore.configure()
  ]
});

// OR

DataStore.configure()
  ]
});
```

To construct a query expression, return a predicate with the primary key of the GSI. You can only use the `eq` operator with this predicate.

For the schema defined above `user => user.lastName.eq('Bobby')` is a valid query expression.

Optionally, you can also add the sort key to this expression with an `and` operator and any of the following operators: `eq | ne | le | lt | ge | gt | beginsWith | between`.

E.g., `user => user.and(user => [user.lastName.eq('Bobby'), user.createdAt.gt('2020-10-10')])`.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/sync/50-selectiveSync.mdx`