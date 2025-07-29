---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/sync/30-savePredicateComparison.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```swift
// Tests only against the local state
if post.title.starts(with: "[Amplify]") 
}

// Only applies the update if the data in the remote backend satisfies the criteria
Amplify.DataStore.save(post, where: Post.keys.title.beginsWith("[Amplify]")) 
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/sync/30-savePredicateComparison.mdx`