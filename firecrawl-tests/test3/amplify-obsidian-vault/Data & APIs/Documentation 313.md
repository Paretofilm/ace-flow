---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/query-predicate-snippet.mdx
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
let p = Post.keys
Amplify.DataStore.query(Post.self, where: p.rating > 4) 
}
```

</Block>

```swift
let p = Post.keys
let sink = Amplify.DataStore.query(Post.self, where: p.rating > 4).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/query-predicate-snippet.mdx`