---
title: Selectively syncing a subset of your data
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/sync/50-selectiveSync.mdx
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

```java
Amplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(Post.class, () -> Post.RATING.gt(5))
        .syncExpression(Comment.class, () -> Comment.STATUS.eq("active"))
        .build())
    .build());
```

</Block>

```kotlin
Amplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(Post::class.java) 
        .syncExpression(Comment::class.java) 
        .build())
    .build())
```

</Block>

```java
RxAmplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(Post.class, () -> Post.RATING.gt(5))
        .syncExpression(Comment.class, () -> Comment.STATUS.eq("active"))
        .build())
    .build());
```

</Block>
</BlockSwitcher>

When DataStore starts syncing, only Posts with `rating > 5` and Comments with `status` equal to `active` will be synced down to the user's local store.

> **Note**: 

Developers should only specify a single `syncExpression` per model. Any subsequent expressions for the same model will be ignored.

### Reevaluate expressions at runtime

Sync expressions get evaluated whenever DataStore starts. In order to have your expressions reevaluated, you can execute `Amplify.DataStore.clear()` or `Amplify.DataStore.stop()` followed by `Amplify.DataStore.start()`.

If you have the following expression and you want to change the filter that gets applied at runtime, you can do the following:

```java
public Integer rating = 5;

public void initialize() 

public void changeSync() 
```

</Block>

```kotlin
var rating: Int = 5;

fun initialize() 
            .build())
        .build())
}

fun changeSync() ,
                
            )
        },
        
    )
}
```

</Block>

```kotlin
var rating = 5

fun initialize() 
            .build())
        .build())
}

suspend fun changeSync()  catch (error: DataStoreException) 
}
```

</Block>

```java
public Integer rating = 5;

public void initialize() 

public void changeSync() 
```

</Block>
</BlockSwitcher>

Each time DataStore starts (via `start` or any other operation: `query`, `save`, `delete`, or `observe`), DataStore will reevaluate the `syncExpressions`.

In the above case, the predicate will contain the value `1`, so all Posts with `rating > 1` will get synced down.

Keep in mind: `Amplify.DataStore.stop()` will retain the local store's existing content. Run `Amplify.DataStore.clear()` to clear the locally-stored contents.

> **Note**: 

When applying a more restrictive filter, clear the local records first by running `DataStore.clear()` instead:

```java
public void changeSync() 
```

</Block>

```kotlin
fun changeSync() ,
                
            )
        },
        
    )
}
```

</Block>

```kotlin
suspend fun changeSync()  catch (error: DataStoreException) 
}
```

</Block>

```java
public void changeSync() 
```

</Block>
</BlockSwitcher>

This will clear the contents of your local store, reevaluate your sync expressions and re-sync the data from the cloud, applying all of the specified predicates to the sync queries.

You can also have your sync expression return `QueryPredicates.all()` in order to remove any filtering for that model. This will have the same effect as the default sync behavior.

```java
public Integer rating = null;

public void initialize() 
                return QueryPredicates.all();
            })
            .build())
        .build());
}
```

</Block>

```kotlin
var rating = null

fun initialize() 
                QueryPredicates.all()
            }
            .build())
        .build())
}
```

</Block>

```java
public Integer rating = null;

public void initialize() 
                return QueryPredicates.all();
            })
            .build())
        .build());
}
```

</Block>
</BlockSwitcher>

> **Note**: 

`DataStore.configure()` should only by called once.

### Advanced use case - Query instead of Scan

You can configure selective sync to retrieve items from DynamoDB with a [query operation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html) against a GSI. By default, the base sync will perform a [scan](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Scan.html). Query operations enable a highly efficient and cost-effective data retrieval for customers running DynamoDB at scale. Learn about creating GSIs with the `@index` directive [here](/gen1/[platform]/build-a-backend/graphqlapi/data-modeling/).

In order to do that, your `syncExpression` should return a predicate that maps to a query expression.

For example, for the following schema:

```graphql
type User @model 
```

To construct a query expression, return a predicate with the primary key of the GSI. You can only use the `eq` operator with this predicate.

For the schema defined above `User.LAST_NAME.eq("Doe")` is a valid query expression.

Optionally, you can also chain the sort key to this expression, using any of the following operators: `eq | ne | le | lt | ge | gt | beginsWith | between`.

E.g., `User.LAST_NAME.eq("Doe").and(User.CREATED_AT.gt("2020-10-10")`.

Both of these sync expressions will result in AWS AppSync retrieving records from Amazon DynamoDB via a query operation:

```java
Amplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(User.class, () -> User.LAST_NAME.eq("Doe"))
        .build())
    .build());

// OR

Amplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(User.class, () -> User.LAST_NAME.eq("Doe").and(User.CREATED_AT.gt("2020-10-10")))
        .build())
    .build());
```

</Block>

```kotlin
Amplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(User::class.java) 
        .build())
    .build())

// OR

Amplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(User::class.java) 
        .build())
    .build())
```

</Block>

```java
RxAmplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(User.class, () -> User.LAST_NAME.eq("Doe"))
        .build())
    .build());

// OR

RxAmplify.addPlugin(AWSDataStorePlugin.builder().dataStoreConfiguration(
    DataStoreConfiguration.builder()
        .syncExpression(User.class, () -> User.LAST_NAME.eq("Doe").and(User.CREATED_AT.gt("2020-10-10")))
        .build())
    .build());
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/sync/50-selectiveSync.mdx`