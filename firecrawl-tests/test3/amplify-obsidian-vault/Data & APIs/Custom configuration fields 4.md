---
title: Custom configuration fields
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/flutter/conflict.mdx
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

To modify these settings, utilize the `options` parameter within the `AmplifyDataStore()` constructor.

### Custom configuration fields
- `errorHandler` - handler function executed when Datastore encounters an unhandled error during its background operations.
- `conflictHandler` - handler function when there is a conflict between two local and remote model instances in a sync operation.
- `syncMaxRecords` - the maximum number of records to sync per execution.
- `syncPageSize` - the page size of each sync execution.
- `syncInterval` - the maximum interval (in seconds) for which the system will continue to perform delta queries. After this interval expires, the system performs a base query to retrieve all data.
- `syncExpressions` - sets a set of sync expressions for a particular model to filter which data is synced locally.  The expression is evaluated each time DataStore is started.
- `authModeStrategy` - sets DataStore to enable or disable multiple authorization types.

### Example

```dart
Future<void> initializeDataStoreWithConflictResolution() async ),
        conflictHandler: (ConflictData data) 
          
          return const ConflictResolutionDecision.applyRemote();
        },
        // Sync configuration defaults:
        syncInterval: 86400,
        syncMaxRecords: 10000,
        syncPageSize: 1000,
      ),
    );
    await Amplify.addPlugin(datastorePlugin);

    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) 
}
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/flutter/conflict.mdx`