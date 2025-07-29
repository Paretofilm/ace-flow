---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/data-access/query-predicate-multiple-snippet.mdx
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
do  catch let error as DataStoreError  catch 
```

</Block>

```swift
let p = Post.keys
let sink = Amplify.Publisher.create .sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

You can also write this in a compositional function manner by replacing the operators with their equivalent predicate statements such as `.gt`, `.and`, etc:

```swift
let p = Post.keys
try await Amplify.DataStore.query(
    Post.self,
    where: p.rating.gt(4).and(p.status.eq(PostStatus.active))
)
```

</Block>

```swift
let p = Post.keys
let sink = Amplify.Publisher.create .sink 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/data-access/query-predicate-multiple-snippet.mdx`