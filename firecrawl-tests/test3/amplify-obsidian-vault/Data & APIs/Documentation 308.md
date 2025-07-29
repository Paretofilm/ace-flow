---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/query-predicate-multiple-snippet.mdx
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
Amplify.DataStore.query(Post.self,
                        where: p.rating > 4 && p.status == PostStatus.active) 
}
```

</Block>

```swift
let p = Post.keys
let sink = Amplify.DataStore.query(
    Post.self,
    where: p.rating > 4 && p.status == PostStatus.active
).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

You can also write this in a compositional function manner by replacing the operators with their equivalent predicate statements such as `.gt`, `.and`, etc:

```swift
let p = Post.keys
Amplify.DataStore.query(Post.self,
                        where: p.rating.gt(4).and(p.status.eq(PostStatus.active))) 
```

</Block>

```swift
let p = Post.keys
let sink = Amplify.DataStore.query(
    Post.self,
    where: p.rating > 4 && p.status == PostStatus.active
).sink 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/query-predicate-multiple-snippet.mdx`