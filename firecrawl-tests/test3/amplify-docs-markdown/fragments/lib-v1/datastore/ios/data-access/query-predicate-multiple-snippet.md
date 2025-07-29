---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/query-predicate-multiple-snippet.mdx
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
