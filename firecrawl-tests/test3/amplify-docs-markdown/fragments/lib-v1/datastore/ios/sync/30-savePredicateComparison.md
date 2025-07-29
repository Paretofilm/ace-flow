---
title: Documentation
source: fragments/lib-v1/datastore/ios/sync/30-savePredicateComparison.mdx
---

# Documentation

```swift
// Tests only against the local state
if post.title.starts(with: "[Amplify]") 
}

// Only applies the update if the data in the remote backend satisfies the criteria
Amplify.DataStore.save(post, where: Post.keys.title.beginsWith("[Amplify]")) 
```
