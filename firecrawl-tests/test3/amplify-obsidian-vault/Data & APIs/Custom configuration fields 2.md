---
title: Custom configuration fields
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/conflict.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Custom configuration fields

DataStore has a few optional configurations, such as the ability to specify a custom handler for error messages that take place in any part of the system. You can also specify a custom conflict handler that runs if a mutation is rejected by AWS AppSync during one of the conflict resolution strategies.

Finally you can configure the number of records to sync as an upper bound on items (per-Model) which will be stored locally on the device, as well as a custom interval in minutes which is an override of the default 24 hour "base query" which runs as part of the Delta Sync process.

### Custom configuration fields
- `errorHandler` - handler function when DataStore encounters an unrecoverable error in one of its ongoing background operations (model synchronization).
- `conflictHandler` - handler function when there is a conflict between two local and remote model instances in a sync operation.
- `syncMaxRecords` - sets the maximum number of records, from the server, to process from a sync operation.
- `syncPageSize` - sets the number of items requested in each page of sync results.
- `syncInterval` - sets the duration of time after which delta syncs will not be preferred over base syncs. The default time unit is minutes.
- `doSyncRetry` - enables retry on sync failure.
- `syncExpression` - sets a sync expression for a particular model to filter which data is synced locally.  The expression is evaluated each time DataStore is started.  The QueryPredicate is applied on both sync and subscriptions.

### Example

The code below illustrates a conflict resolution handler for the `Post` model that retries a mutation with the same title, but the most recent remote data for all other fields. The conflict resolution handler discards conflicts for all other models (by passing `ConflictResolutionDecision.applyRemote()` to `onDecision.accept(...)`).

```java
DataStoreConfiguration config = DataStoreConfiguration.builder()
      .errorHandler(error -> )
      .conflictHandler((conflictData, onDecision) ->  else 
      })
      // Set the duration of time after which delta syncs will not be preferred over base syncs
      .syncInterval(1, TimeUnit.DAYS)
      // Set the maximum number of records, from the server, to process from a sync operation
      .syncMaxRecords(10_000)
      // Set the number of items requested in each page of sync results
      .syncPageSize(1_000)
      .build();
AWSDataStorePlugin dataStorePlugin = AWSDataStorePlugin.builder().dataStoreConfiguration(config).build();
```

</Block>

```kotlin
val config = DataStoreConfiguration.builder()
    .errorHandler 
    .conflictHandler  else 
    }
    // Set the duration of time after which delta syncs will not be preferred over base syncs
    .syncInterval(1, TimeUnit.DAYS)
    // Set the maximum number of records, from the server, to process from a sync operation
    .syncMaxRecords(10_000)
    // Set the number of items requested in each page of sync results
    .syncPageSize(1_000)
    .build()
val dataStorePlugin = AWSDataStorePlugin.builder().dataStoreConfiguration(config).build()
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/conflict.mdx`