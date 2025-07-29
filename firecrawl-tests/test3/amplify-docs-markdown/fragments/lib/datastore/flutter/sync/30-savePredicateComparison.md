---
title: Documentation
source: fragments/lib/datastore/flutter/sync/30-savePredicateComparison.mdx
---

# Documentation

```dart
// Tests only against the local state
Future<void> savePredicateLocally(Post post) async 
}

// Only applies the update if the data in the remote backend satisfies the criteria
Future<void> savePredicateRemotely(Post post) async  on DataStoreException catch (e) 
}
```
