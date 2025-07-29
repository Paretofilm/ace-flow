---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/query-sort-snippet.mdx
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
Amplify.DataStore.query(Post.self, sort: .ascending(Post.keys.rating)) 
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self, sort: .ascending(Post.keys.rating)).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/query-sort-snippet.mdx`