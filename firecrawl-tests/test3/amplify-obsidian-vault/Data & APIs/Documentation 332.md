---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/flutter/sync/30-savePredicateComparison.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/flutter/sync/30-savePredicateComparison.mdx`